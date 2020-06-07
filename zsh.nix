let
  DEV_PATH = "/opt/dev/dev.sh";

  sourceFile = file: "[ -f ${file} ] && source ${file}";
in
  {
    enable = true;
    shellAliases = import ./aliases.nix;
    defaultKeymap = "viins";
    initExtra = ''
      dev() {
        ${sourceFile DEV_PATH}
        dev $@
      }

      precmd() {
        GIT_BRANCH=$(git symbolic-ref HEAD --short)
      }
    '';
    sessionVariables = with builtins; rec {
      EDITOR = "vim";
      KEYTIMEOUT = 1;
      KUBECONFIG = builtins.concatStringsSep ":" [
        "$HOME/.kube/config"
        "$HOME/.kube/config.shopify.cloudplatform"
      ];
      PATH = "$PATH:$HOME/.nix-profile/bin";
      NIX_PATH = "$NIX_PATH:$HOME/.nix-defexpr/channels";
      PROMPT = import ./prompt.nix;
    };
  }
