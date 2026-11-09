_: {
  programs.zsh.shellAliases.wt = ''
    () {
      setopt localoptions pipefail
      local ROOT="$HOME/Developer/devin-webapp" WT WIN LABEL BRANCH REF PR
      local NEW=false TRACK=true
      local -a CMD
      if [[ $# == 2 && "$1" == -b ]]; then
        NEW=true
        TRACK=false
        shift
      fi
      [[ $# == 1 && -n "$1" ]] || { printf 'Usage: wt <branch|pull-request-url> | wt -b <new-branch>\n' >&2; return 2 }
      BRANCH="$1"
      REF="refs/heads/$BRANCH"
      if [[ "$1" == *://* ]]; then
        [[ "$NEW" == false && "$1" =~ '^https://github[.]com/usacognition/devin-webapp/pull/[1-9][0-9]*([/#?].*)?$' ]] || {
          printf 'Expected a usacognition/devin-webapp pull request URL.\n' >&2; return 2
        }
        PR=$(gh pr view "$1" --json number,headRefName,isCrossRepository) || return
        BRANCH=$(jq -er 'if .isCrossRepository then "pr/\(.number)" else .headRefName end' <<< "$PR") || return
        REF=$(jq -er '"refs/pull/\(.number)/head"' <<< "$PR") || return
        TRACK=$(jq -er '.isCrossRepository | not | tostring' <<< "$PR") || return
      fi
      git check-ref-format --branch "$BRANCH" >/dev/null || return
      git -C "$ROOT" worktree prune || return
      WT=$(git -C "$ROOT" worktree list --porcelain | awk -v b="refs/heads/$BRANCH" '$1=="worktree"{w=substr($0,10)} $2==b{print w}') || return
      if [[ -n "$WT" ]]; then
        [[ "$NEW" == false ]] || { printf 'Branch already has a worktree: %s\n' "$BRANCH" >&2; return 2 }
        LABEL="''${WT#$ROOT/}"
        WIN=$(rex window ls --json | jq -r --arg l "$LABEL" 'first(.windows[] | select(.label==$l).window_id) // empty') || return
      else
        WT="$ROOT/$BRANCH"
        LABEL="$BRANCH"
        if [[ "$NEW" == false ]] && git -C "$ROOT" show-ref --verify --quiet "refs/heads/$BRANCH"; then
          git -C "$ROOT" worktree add "$WT" "$BRANCH" || return
        else
          [[ "$NEW" == false ]] || REF=refs/heads/main
          git -C "$ROOT" fetch origin "$REF" || return
          git -C "$ROOT" worktree add --no-track -b "$BRANCH" "$WT" FETCH_HEAD || return
          if [[ "$TRACK" == true ]]; then
            git -C "$ROOT" config "branch.$BRANCH.remote" origin && git -C "$ROOT" config "branch.$BRANCH.merge" "refs/heads/$BRANCH" || return
          fi
        fi
        CMD=(-- zsh -c './setup.sh && exec zsh')
      fi
      [[ -n "$WIN" ]] || WIN=$(rex window new "$LABEL" --cwd "$WT/apps/chisel" --json "''${CMD[@]}" | jq -er .window_id) || return
      rex window focus "$WIN" >/dev/null
    }'';
}
