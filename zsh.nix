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
      size = 50000;
      save = 50000;
    };
    shellAliases = import ./aliases.nix;
    initExtra = ''
      setopt autocd autopushd

      bindkey -v
      bindkey "^?" backward-delete-char

      ${sourceFile NIX_PATH}
      ${sourceFile DEV_PATH}
    '';

    sessionVariables = rec {
      EDITOR = "vim";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;
      KEYTIMEOUT = 1;
      GOPATH = "$HOME/go";
      GO111MODULE = "on";
      FZF_DEFAULT_OPTS = "
      --color=hl:6,fg+:5,bg+:0,hl+:5,info:6,prompt:6
      --color=pointer:5,marker:5,spinner:4,header:4
      ";
    };
  }
