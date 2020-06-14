let
  pathJoin = builtins.concatStringsSep ":";
  prompt = import ./prompt.nix;
  sourceFile = file: "[ -f ${file} ] && source ${file}";
in
  {
    autocd = true;
    dotDir = ".config/zsh";
    enable = true;
    shellAliases = import ./aliases.nix;
    defaultKeymap = "viins";
    initExtra = ''
      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete

      dev() {
        ${sourceFile "opt/dev/dev.sh"}
        dev $@
      }

      ${prompt.precmd}

      setopt prompt_subst
    '';
    sessionVariables = {
      EDITOR = "vim";
      KEYTIMEOUT = 1;
      KUBECONFIG = pathJoin [
        "$HOME/.kube/config"
        "$HOME/.kube/config.shopify.cloudplatform"
      ];
      TERM = "xterm-256color";
      PATH = pathJoin [
        "$PATH"
        "$HOME/.nix-profile/bin"
      ];
      PROMPT = prompt.ps1;
      NIX_PATH = pathJoin [
        "$NIX_PATH"
        "$HOME/.nix-defexpr/channels"
      ];
      PASSWORD_STORE_DIR = "$HOME/.config/pass";
    };
  }
