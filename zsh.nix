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
      --color=fg:-1,bg:-1,hl:#88c0d0,fg+:#b48ead,bg+:#2e3440,hl+:#b48ead,info:#88c0d0
      --color=prompt:#88c0d0,pointer:#b48ead,marker:#b48ead,spinner:#81a1c1,header:#81a1c1
      ";
    };
  }
