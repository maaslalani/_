let
  pathJoin = builtins.concatStringsSep ":";
  prompt = import ./prompt.nix;
  sourceFile = file: "[ -f ${file} ] && source ${file}";
  zleColors = "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
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
        ${sourceFile "/opt/dev/dev.sh"}
        dev $@
      }

      ${prompt.precmd}

      setopt prompt_subst
      zstyle ':completion:*' list-colors "${zleColors}"
    '';
    sessionVariables = {
      EDITOR = "nvim";
      CLICOLOR = 1;
      KEYTIMEOUT = 1;
      KUBECONFIG = pathJoin [
        "$HOME/.kube/config"
        "$HOME/.kube/config.shopify.cloudplatform"
      ];
      LSCOLORS = "exfxcxdxbxegedabagacad";
      NIX_PATH = pathJoin [
        "$NIX_PATH"
        "$HOME/.nix-defexpr/channels"
      ];
      PATH = pathJoin [
        "$PATH"
        "$HOME/.nix-profile/bin"
      ];
      PROMPT = prompt.ps1;
      PASSWORD_STORE_DIR = "$HOME/.config/pass";
      TERM = "xterm-256color";
    };
  }
