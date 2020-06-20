let
  prompt = import ./prompt.nix;
in
  with builtins; {
    autocd = true;
    dotDir = ".config/zsh";
    enable = true;
    shellAliases = import ./aliases.nix;
    defaultKeymap = "viins";
    initExtra = ''
      bindkey -s ^V ^Uvim .^M
      bindkey ^P up-history
      bindkey ^N down-history
      bindkey ^? backward-delete-char
      bindkey ^[[Z reverse-menu-complete

      dev() {
        source /opt/dev/dev.sh
        dev $@
      }

      ${prompt.precmd}

      setopt prompt_subst
    '';
    sessionVariables = {
      EDITOR = "nvim";
      CLICOLOR = 1;
      KEYTIMEOUT = 1;
      KUBECONFIG = concatStringsSep ":" [
        "$HOME/.kube/config"
        "$HOME/.kube/config.shopify.cloudplatform"
      ];
      LSCOLORS = "exfxcxdxbxegedabagacad";
      NIX_PATH = concatStringsSep ":" [
        "$NIX_PATH"
        "$HOME/.nix-defexpr/channels"
      ];
      PATH = concatStringsSep ":" [
        "$PATH"
        "$HOME/.nix-profile/bin"
      ];
      PROMPT = prompt.ps1;
      PASSWORD_STORE_DIR = "$HOME/.config/pass";
      TERM = "xterm-256color";
    };
  }
