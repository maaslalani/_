{
  colors,
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
  purePrompt = pkgs.pure-prompt.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace pure.zsh \
          --replace-fail 'if [[ $1 == precmd ]]; then' \
          'if [[ $1 == precmd && -n $prompt_pure_last_prompt ]]; then'
      '';
  });
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

      fpath+=(
        "$HOME/.nix-profile/share/zsh/site-functions"
        "${purePrompt}/share/zsh/site-functions"
      )

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      setopt combining_chars prompt_subst
      disable log

      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete
      bindkey "$terminfo[kdch1]" delete-char
      bindkey "$terminfo[khome]" beginning-of-line
      bindkey "$terminfo[kend]" end-of-line
      bindkey "$terminfo[kcuu1]" up-line-or-search
      bindkey "$terminfo[kcud1]" down-line-or-search

      if [[ -z $__ETC_PROFILE_NIX_SOURCED && -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      [[ -n $TTY ]] && export GPG_TTY=$TTY

      PURE_PROMPT_SYMBOL='>'
      PURE_PROMPT_VICMD_SYMBOL='v'
      zstyle ':prompt:pure:git:arrow' color yellow
      zstyle ':prompt:pure:git:branch' color magenta
      zstyle ':prompt:pure:git:branch:cached' color magenta
      zstyle ':prompt:pure:git:dirty' color red
      autoload -Uz promptinit
      promptinit
      prompt pure

      ${integrations}
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.fzf = {
    colors = {
      bg = colors.primary.background;
      "bg+" = colors.primary.background;
      fg = colors.primary.foreground;
      "fg+" = colors.bright.white;
      hl = colors.normal.magenta;
      "hl+" = colors.bright.magenta;
      ghost = colors.bright.black;
      gutter = colors.primary.background;
      info = colors.bright.black;
      pointer = colors.bright.blue;
      prompt = colors.bright.blue;
      query = colors.primary.foreground;
      separator = colors.separator;
    };
    enable = true;
    enableZshIntegration = false;
  };
}
