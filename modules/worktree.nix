_: {
  programs.zsh.shellAliases.wt = ''
    () {
      setopt localoptions pipefail
      local ROOT WT WIN LABEL BRANCH REF PR REPO DIR PREFIX
      local TRACK=true
      local -a CMD
      [[ $# == 1 && -n "$1" ]] || { printf 'Usage: wt <branch|pull-request-url>\n' >&2; return 2 }
      ROOT=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) && ROOT="''${ROOT:h}"
      PREFIX=$(git rev-parse --show-prefix 2>/dev/null)
      BRANCH="$1"
      REF="refs/heads/$BRANCH"
      if [[ "$1" == *://* ]]; then
        PR=$(gh pr view "$1" --json url,number,headRefName,isCrossRepository) || return
        BRANCH=$(jq -er 'if .isCrossRepository then "pr/\(.number)" else .headRefName end' <<< "$PR") || return
        REF=$(jq -er '"refs/pull/\(.number)/head"' <<< "$PR") || return
        TRACK=$(jq -er '.isCrossRepository | not | tostring' <<< "$PR") || return
        REPO=$(jq -er '.url | sub("^https?://[^/]+/"; "") | sub("/pull/.*"; "") | ascii_downcase' <<< "$PR") || return
        for DIR in "$HOME"/Developer/*(/N); do
          [[ "''${(L)$(git -C "$DIR" remote get-url origin 2>/dev/null)%.git}" == *[:/]"$REPO" ]] && break
          DIR=
        done
        [[ -n "$DIR" ]] || { printf 'No clone of %s in ~/Developer.\n' "$REPO" >&2; return 1 }
        [[ "$DIR" == "$ROOT" ]] || PREFIX=
        ROOT="$DIR"
      fi
      [[ -n "$ROOT" ]] || { printf 'Not in a git repository.\n' >&2; return 1 }
      git check-ref-format --branch "$BRANCH" >/dev/null || return
      git -C "$ROOT" worktree prune || return
      WT=$(git -C "$ROOT" worktree list --porcelain | awk -v b="refs/heads/$BRANCH" '$1=="worktree"{w=substr($0,10)} $2==b{print w}') || return
      if [[ -n "$WT" ]]; then
        LABEL="''${WT#$ROOT/}"
        WIN=$(rex window ls --json | jq -r --arg l "$LABEL" 'first(.windows[] | select(.label==$l).window_id) // empty') || return
      else
        WT="$ROOT/$BRANCH"
        LABEL="$BRANCH"
        if git -C "$ROOT" show-ref --verify --quiet "refs/heads/$BRANCH"; then
          git -C "$ROOT" worktree add "$WT" "$BRANCH" || return
        else
          git -C "$ROOT" fetch origin "$REF" || {
            [[ -z "$PR" ]] || return
            printf 'Creating new branch from the default branch: %s\n' "$BRANCH" >&2
            TRACK=false
            git -C "$ROOT" fetch origin HEAD || return
          }
          git -C "$ROOT" worktree add --no-track -b "$BRANCH" "$WT" FETCH_HEAD || return
          if [[ "$TRACK" == true ]]; then
            git -C "$ROOT" config "branch.$BRANCH.remote" origin && git -C "$ROOT" config "branch.$BRANCH.merge" "refs/heads/$BRANCH" || return
          fi
        fi
        CMD=(-- zsh -c '{ [[ ! -x setup.sh ]] || ./setup.sh } && exec zsh')
      fi
      [[ -d "$WT/$PREFIX" ]] || PREFIX=
      [[ -n "$WIN" ]] || WIN=$(rex window new "$LABEL" --cwd "$WT/$PREFIX" --json "''${CMD[@]}" | jq -er .window_id) || return
      rex window focus "$WIN" >/dev/null
    }'';
}
