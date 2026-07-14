{
  config,
  pkgs,
  ...
}: let
  syntaxHighlighting = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "5eb494852ebb99cf5c2c2bffee6b74e6f1bf38d0";
    sha256 = "8gyZe6OPVLMdfruHJAHcyYeuiyvMTLvuX1UnUOv8eg8=";
  };
  prompt = ''
    autoload -Uz add-zsh-hook
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr ' %F{red}*%f'
    zstyle ':vcs_info:git:*' stagedstr ' %F{green}+%f'
    zstyle ':vcs_info:git:*' formats ' %F{magenta}(%B%b%%b)%f%u%c'
    zstyle ':vcs_info:git:*' actionformats ' %F{magenta}(%B%b%%b|%a)%f%u%c'

    export PROMPT='%F{blue}%3~%f''${vcs_info_msg_0_}
    %(?.%F{green}>%f.%F{red}>%f) '

    function __prompt_vcs_info() {
      builtin cd -q -- "$1" || return
      autoload -Uz vcs_info
      vcs_info
      print -r -- "$PWD"
      print -r -- "$vcs_info_msg_0_"
    }

    function __prompt_vcs_info_done() {
      local job=$1 code=$2 output=$3
      [[ $job == __prompt_vcs_info && $code == 0 ]] || return

      local -a result
      result=("''${(@f)output}")
      [[ $result[1] == $PWD ]] || return

      vcs_info_msg_0_=$result[2]
      [[ -o zle ]] && zle reset-prompt
    }

    function __prompt_vcs_info_start() {
      if [[ $__prompt_vcs_pwd != $PWD ]]; then
        vcs_info_msg_0_=
        __prompt_vcs_pwd=$PWD
      fi

      async_job vcs-info __prompt_vcs_info "$PWD"
    }

    function __init_prompt_vcs() {
      source ${pkgs.pure-prompt}/share/zsh/site-functions/async
      async_start_worker vcs-info
      async_register_callback vcs-info __prompt_vcs_info_done
      add-zsh-hook precmd __prompt_vcs_info_start
      __prompt_vcs_info_start
      unfunction __init_prompt_vcs
    }
  '';
  integrations = ''
    function __init_completion() {
      autoload -Uz compinit
      local zcompdump=${config.xdg.cacheHome}/zsh/zcompdump
      [[ -d ${config.xdg.cacheHome}/zsh ]] || mkdir -p ${config.xdg.cacheHome}/zsh
      if [[ -f $zcompdump ]]; then
        compinit -C -d "$zcompdump"
      else
        compinit -d "$zcompdump"
      fi
      unfunction __init_completion
    }

    function __init_zoxide() {
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      unfunction __init_zoxide
    }

    function __init_fzf() {
      source <(${pkgs.fzf}/bin/fzf --zsh)
      unfunction __init_fzf
    }

    function __init_ghostty() {
      setopt local_options no_aliases
      if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
        source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
      fi
      unfunction __init_ghostty
    }

    function __init_syntax_highlighting() {
      source ${syntaxHighlighting}/zsh-syntax-highlighting.plugin.zsh
      unfunction __init_syntax_highlighting
    }

    zsh-defer -m -p -r __init_ghostty
    zsh-defer -m -p -r __init_prompt_vcs
    zsh-defer -m -p -r __init_completion
    zsh-defer -m -p -r __init_zoxide
    zsh-defer -m -p -r __init_fzf
    zsh-defer -m __init_syntax_highlighting
  '';
in {
  imports = [
    ./aliases.nix
  ];

  programs.zsh = {
    autocd = true;
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    envExtra = ''
      unsetopt GLOBAL_RCS
    '';
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    defaultKeymap = "viins";
    sessionVariables = rec {
      CARGO_BIN = "$HOME/.cargo/bin";
      CARGO_INCREMENTAL = "0";
      CARGO_TARGET_DIR = "${config.xdg.cacheHome}/cargo";
      COLORTERM = "truecolor";
      EDITOR = "hx";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GOBIN = "${GOPATH}/bin";
      GOPATH = "${config.xdg.configHome}/go";
      KEYTIMEOUT = "1";
      LOCAL_BIN = "$HOME/.local/bin";
      NIX_BIN = "$HOME/.nix-profile/bin";
      NIX_PATH = builtins.concatStringsSep ":" ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
      NODE_NO_WARNINGS = "1";
      NOTES = "$HOME/Documents/notes";
      OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
      PATH = builtins.concatStringsSep ":" [GOBIN NIX_BIN LOCAL_BIN CARGO_BIN "$PATH"];
      RUSTC_WRAPPER = "sccache";
      SHELL = "${config.programs.zsh.package}/bin/zsh";
      SHELL_SESSIONS_DISABLE = "1";
      TYPST_FONT_PATHS = "$HOME/.nix-profile/share/fonts";
      XDG_CACHE_HOME = config.xdg.cacheHome;
      XDG_CONFIG_HOME = config.xdg.configHome;
      XDG_DATA_HOME = config.xdg.dataHome;
    };
    completionInit = "";
    initContent = ''
      source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh

      fpath+="$HOME/.nix-profile/share/zsh/site-functions"

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      setopt combining_chars prompt_subst
      disable log

      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete
      [[ -n $terminfo[kdch1] ]] && bindkey "$terminfo[kdch1]" delete-char
      [[ -n $terminfo[khome] ]] && bindkey "$terminfo[khome]" beginning-of-line
      [[ -n $terminfo[kend] ]] && bindkey "$terminfo[kend]" end-of-line
      [[ -n $terminfo[kcuu1] ]] && bindkey "$terminfo[kcuu1]" up-line-or-search
      [[ -n $terminfo[kcud1] ]] && bindkey "$terminfo[kcud1]" down-line-or-search

      if [[ -z $__ETC_PROFILE_NIX_SOURCED && -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      [[ -n $TTY ]] && export GPG_TTY=$TTY

      ${prompt}
      ${integrations}
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
  };
}
