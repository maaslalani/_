{pkgs}: let
  module = import ../modules/shell.nix {
    colors = {};
    config = {};
    inherit pkgs;
  };
in
  pkgs.runCommand "rwt-tests" {nativeBuildInputs = [pkgs.zsh pkgs.git pkgs.gawk pkgs.jq];} ''
    zsh -f <<'ZSH'
    setopt errexit nounset pipefail
    export HOME="$TMPDIR/home with spaces"
    TEST_ROOT="$HOME/Developer/devin-webapp"

    rwt() {
      ${module.programs.zsh.shellAliases.rwt} "$@"
    }

    record() {
      jq -cn --args -- '$ARGS.positional' "$@" >> "$CALLS"
    }

    git() {
      record git "$@"
      if [[ "$1" == check-ref-format ]]; then
        command git "$@"
        return
      fi
      [[ "$1" == -C && "$2" == "$TEST_ROOT" ]] || return 90
      shift 2
      case "$1 $2" in
        "worktree prune") return 0 ;;
        "worktree list")
          if [[ -n "$TEST_WORKTREE" ]]; then
            printf 'worktree %s\nbranch refs/heads/%s\n\n' "$TEST_WORKTREE" "$TEST_BRANCH"
          fi
          return "$GIT_LIST_CODE"
          ;;
        "fetch origin") return "$FETCH_CODE" ;;
        "worktree add")
          [[ "$4" == -b ]] && return "$CREATE_CODE"
          return "$ADD_CODE"
          ;;
        config*) return "$CONFIG_CODE" ;;
        *) return 91 ;;
      esac
    }

    gh() {
      record gh "$@"
      printf '%s\n' "$TEST_BRANCH"
      return "$PR_CODE"
    }

    rex() {
      record rex "$@"
      case "$1" in
        ls) printf '%s\n' "$SESSIONS"; return "$REX_LIST_CODE" ;;
        new) printf '%s\n' "$CREATED"; return "$NEW_CODE" ;;
        do) return "$FOCUS_CODE" ;;
        *) return 92 ;;
      esac
    }

    reset_case() {
      CALLS="$PWD/$1.jsonl"
      : > "$CALLS"
      TEST_BRANCH="maas/topic"
      TEST_WORKTREE="$TEST_ROOT/renamed topic"
      SESSIONS='{"sessions":[{"label":"other","session_id":"session:other"},{"label":"renamed topic","session_id":"session:existing"}]}'
      CREATED='{"session_id":"session:new"}'
      GIT_LIST_CODE=0 FETCH_CODE=0 ADD_CODE=0 CREATE_CODE=0 CONFIG_CODE=0
      PR_CODE=0 REX_LIST_CODE=0 NEW_CODE=0 FOCUS_CODE=0
    }

    run() {
      local expected="$1" code=0
      shift
      rwt "$@" > "$CALLS.stdout" 2> "$CALLS.stderr" || code=$?
      if (( code != expected )); then
        cat "$CALLS" "$CALLS.stdout" "$CALLS.stderr"
        printf 'Expected exit %s, got %s\n' "$expected" "$code" >&2
        exit 1
      fi
    }

    check() {
      jq -es --arg root "$TEST_ROOT" --arg wt "$TEST_WORKTREE" --arg branch "$TEST_BRANCH" "$1" "$CALLS" > /dev/null
    }

    reset_case reuse
    run 0 "$TEST_BRANCH"
    check '[.[] | select(.[0] == "rex")] == [["rex","ls","--json"],["rex","do","session.select","session_id=session:existing"]]
      and all(.[]; .[3] != "fetch" and .[3] != "config" and .[4] != "add")'

    reset_case missing_session
    SESSIONS='{"sessions":[]}'
    run 0 "$TEST_BRANCH"
    check '[.[] | select(.[0] == "rex")] == [["rex","ls","--json"],
      ["rex","new","renamed topic","--cwd",$wt + "/apps/chisel","--json"],
      ["rex","do","session.select","session_id=session:new"]]'

    reset_case remote_branch
    TEST_WORKTREE=""
    run 0 "$TEST_BRANCH"
    check 'any(.[]; . == ["git","-C",$root,"fetch","origin",$branch + ":" + $branch])
      and any(.[]; . == ["git","-C",$root,"worktree","add",$root + "/topic",$branch])
      and any(.[]; . == ["git","-C",$root,"config","branch." + $branch + ".remote","origin"])
      and any(.[]; . == ["git","-C",$root,"config","branch." + $branch + ".merge","refs/heads/" + $branch])
      and [.[] | select(.[0] == "rex")] == [
        ["rex","new","topic","--cwd",$root + "/topic/apps/chisel","--json","--","zsh","-c","./setup.sh; exec zsh"],
        ["rex","do","session.select","session_id=session:new"]]'

    reset_case local_branch
    TEST_WORKTREE="" FETCH_CODE=1 ADD_CODE=1
    run 0 "$TEST_BRANCH"
    check 'any(.[]; . == ["git","-C",$root,"worktree","add",$root + "/topic","-b",$branch])
      and any(.[]; .[0:2] == ["rex","new"])'

    reset_case pull_request
    run 0 https://github.com/example/repo/pull/42
    check '.[0] == ["gh","pr","view","https://github.com/example/repo/pull/42","--json","headRefName","-q",".headRefName"]
      and .[-1] == ["rex","do","session.select","session_id=session:existing"]'

    reset_case missing_argument
    run 2
    check 'length == 0'

    reset_case extra_argument
    run 2 "$TEST_BRANCH" extra
    check 'length == 0'

    reset_case invalid_branch
    run 128 --invalid
    check 'length == 1 and .[0][0:2] == ["git","check-ref-format"]'

    reset_case pull_request_failure
    PR_CODE=7
    run 7 https://github.com/example/repo/pull/42
    check 'length == 1 and .[0][0] == "gh"'

    reset_case worktree_list_failure
    GIT_LIST_CODE=8
    run 8 "$TEST_BRANCH"
    check 'all(.[]; .[0] != "rex" and .[4] != "add")'

    reset_case session_list_failure
    REX_LIST_CODE=9
    run 9 "$TEST_BRANCH"
    check '[.[] | select(.[0] == "rex")] == [["rex","ls","--json"]]'

    reset_case worktree_creation_failure
    TEST_WORKTREE="" ADD_CODE=1 CREATE_CODE=6
    run 6 "$TEST_BRANCH"
    check 'all(.[]; .[0] != "rex" and .[3] != "config")'

    reset_case branch_config_failure
    TEST_WORKTREE="" CONFIG_CODE=5
    run 5 "$TEST_BRANCH"
    check 'all(.[]; .[0] != "rex")'

    reset_case session_creation_failure
    SESSIONS='{"sessions":[]}' NEW_CODE=10
    run 10 "$TEST_BRANCH"
    check 'all(.[]; .[0:2] != ["rex","do"])'

    reset_case missing_session_id
    SESSIONS='{"sessions":[]}' CREATED='{}'
    run 1 "$TEST_BRANCH"
    check 'all(.[]; .[0:2] != ["rex","do"])'

    reset_case focus_failure
    FOCUS_CODE=11
    run 11 "$TEST_BRANCH"

    printf 'Rex worktree checks passed.\n'
    ZSH
    touch "$out"
  ''
