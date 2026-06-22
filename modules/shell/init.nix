{identity, ...}: {
  programs.zsh.initContent = ''
    fpath+="$HOME/.nix-profile/share/zsh/site-functions"
    fpath+="$HOME/.nix-profile/share/zsh/5.8/functions"

    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

    setopt prompt_subst
    setopt histignorealldups

    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^?' backward-delete-char
    bindkey '^[[Z' reverse-menu-complete

    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi

    __branch() {
      local BRANCH="$1"
      local SAFE_BRANCH="''${BRANCH//\//-}"
      local REPO=$HOME/Developer/copilot
      local WORKTREE=$HOME/Developer/copilot.worktrees/$SAFE_BRANCH
      local SESSION=copilot_$SAFE_BRANCH
      git -C $REPO worktree add -b ${identity.githubUser}/$BRANCH $WORKTREE
      tmux new-session -dc $WORKTREE -s $SESSION
      tmux switch-client -t $SESSION
    }

    __review() {
      local BRANCH="$1"
      local SAFE_BRANCH="''${BRANCH//\//-}"
      local REPO=$HOME/Developer/copilot
      local WORKTREE=$HOME/Developer/copilot.worktrees/$SAFE_BRANCH
      local SESSION=copilot_$SAFE_BRANCH
      git -C $REPO worktree add $WORKTREE $BRANCH
      tmux new-session -dc $WORKTREE -s $SESSION
      tmux switch-client -t $SESSION
    }

    gcm() {
      git commit -m "$*"
    }

    precmd() {
      if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
        GIT_BRANCH="%F{magenta}(%B$(git branch --show-current)%b)%f"
        GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
      else
        unset GIT_BRANCH
        unset GIT_STATUS
      fi
    }

    export GPG_TTY=$(tty)

    export PROMPT="%F{blue}%3~%f \$GIT_BRANCH %F{red}\$GIT_STATUS%f
    %(?.%F{green}>%f.%F{red}>%f) "
  '';
}
