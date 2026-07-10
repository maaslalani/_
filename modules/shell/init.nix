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

    typeset -g git_remote_status=
    _git_remote_status() {
      local behind ahead
      git_remote_status=
      read -r behind ahead < <(git rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null) || return 0
      if ((ahead > 0)); then
        git_remote_status+=' %F{yellow}↑%f'
      fi
      if ((behind > 0)); then
        git_remote_status+=' %F{yellow}↓%f'
      fi
    }
    add-zsh-hook precmd _git_remote_status

    export GPG_TTY=$(tty)

    export PROMPT='%F{blue}%3~%f''${vcs_info_msg_0_}''${git_remote_status}
    %(?.%F{green}>%f.%F{red}>%f) '
  '';
}
