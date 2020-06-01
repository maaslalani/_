let
  NIX_PATH = "~/.nix-profile/etc/profile.d/nix.sh";
  DEV_PATH = "/opt/dev/dev.sh";

  sourceFile = file: "[ -f ${file} ] && source ${file}";
in
  {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      path = "~/.zsh_history";
      size = 1000;
      save = 1000;
    };
    shellAliases = import ./aliases.nix;
    initExtra = ''
      setopt autocd autopushd

      bindkey -v
      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete

      ${sourceFile NIX_PATH}
      ${sourceFile DEV_PATH}

      [ -z "$TMUX" ] && tmux new-session -A -s "#"
    '';

    sessionVariables = rec {
      EDITOR = "vim";
      GIT_EDITOR = EDITOR;
      VISUAL = EDITOR;

      FZF_DEFAULT_OPTS = "
        --color=hl:6,fg+:5,bg+:0,hl+:5,info:6,prompt:6
        --color=pointer:5,marker:5,spinner:4,header:4
      ";

      GO111MODULE = "on";
      GOPATH = "$HOME/go";

      KEYTIMEOUT = 1;

      KUBECONFIG = "/Users/maas/.kube/config:/Users/maas/.kube/config.shopify.cloudplatform";
    };
  }
