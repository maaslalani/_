{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
  ];

  programs.zsh = {
    autocd = true;
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
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
    initContent = ''
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

      export GPG_TTY=$(tty)

      export PROMPT='%F{blue}%3~%f''${vcs_info_msg_0_}
      %(?.%F{green}>%f.%F{red}>%f) '
    '';
    completionInit = ''
      autoload -Uz compinit
      _zcompdump=${config.xdg.cacheHome}/zsh/zcompdump
      [[ -d ${config.xdg.cacheHome}/zsh ]] || mkdir -p ${config.xdg.cacheHome}/zsh
      if [[ -f $_zcompdump ]]; then
        compinit -C -d $_zcompdump
      else
        compinit -d $_zcompdump
      fi
    '';
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "5eb494852ebb99cf5c2c2bffee6b74e6f1bf38d0";
          sha256 = "8gyZe6OPVLMdfruHJAHcyYeuiyvMTLvuX1UnUOv8eg8=";
        };
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
