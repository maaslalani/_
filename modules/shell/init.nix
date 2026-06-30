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
    zstyle ':vcs_info:git:*' unstagedstr ' %F{gray}*%f'
    zstyle ':vcs_info:git:*' stagedstr ' %F{green}+%f'
    zstyle ':vcs_info:git:*' formats ' %F{magenta}(%B%b%%b)%f%u%c'
    zstyle ':vcs_info:git:*' actionformats ' %F{magenta}(%B%b%%b|%a)%f%u%c'
    add-zsh-hook precmd vcs_info

    export GPG_TTY=$(tty)

    export PROMPT='%F{blue}%3~%f''${vcs_info_msg_0_}
    %(?.%F{green}>%f.%F{red}>%f) '
  '';
}
