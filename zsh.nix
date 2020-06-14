let
  DEV_PATH = "/opt/dev/dev.sh";

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

      dev() {
        ${sourceFile DEV_PATH}
        dev $@
      }

      precmd() {
        if test -d .git; then
          GIT_BRANCH=$(git symbolic-ref --short HEAD)
        else
          GIT_BRANCH=""
        fi
      }

      setopt prompt_subst
    '';
    sessionVariables = with builtins; rec {
      EDITOR = "vim";
      KEYTIMEOUT = 1;
      KUBECONFIG = concatStringsSep ":" [
        "$HOME/.kube/config"
        "$HOME/.kube/config.shopify.cloudplatform"
      ];
      TERM = "xterm-256color";
      PATH = "$PATH:$HOME/.nix-profile/bin";
      PROMPT = import ./prompt.nix;
      NIX_PATH = "$NIX_PATH:$HOME/.nix-defexpr/channels";
      PASSWORD_STORE_DIR = "$HOME/.config/pass";
    };
  }
