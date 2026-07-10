{
  programs.zsh.initContent = ''
    fpath+="$HOME/.nix-profile/share/zsh/site-functions"

    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

    setopt prompt_subst

    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^?' backward-delete-char
    bindkey '^[[Z' reverse-menu-complete

    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi

    autoload -Uz vcs_info add-zsh-hook
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr ' %F{red}*%f'
    zstyle ':vcs_info:git:*' stagedstr ' %F{green}+%f'
    zstyle ':vcs_info:git:*' formats ' %F{magenta}(%B%b%%b)%f%u%c'
    zstyle ':vcs_info:git:*' actionformats ' %F{magenta}(%B%b%%b|%a)%f%u%c'
    add-zsh-hook precmd vcs_info

    typeset -g git_unpushed=
    _git_unpushed() {
      local commit
      git_unpushed=
      commit=$(git rev-list --max-count=1 '@{upstream}..HEAD' 2>/dev/null) || return 0
      if [[ -n "$commit" ]]; then
        git_unpushed=' %F{yellow}↑%f'
      fi
    }
    add-zsh-hook precmd _git_unpushed

    export GPG_TTY=$(tty)

    export PROMPT='%F{blue}%3~%f''${vcs_info_msg_0_}''${git_unpushed}
    %(?.%F{green}>%f.%F{red}>%f) '
  '';
}
