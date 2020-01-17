{ config, pkgs, ... }:

let
  NIX_PATH = "~/.nix-profile/etc/profile.d/nix.sh";
  DEV_PATH = "/opt/dev/dev.sh";

  sourceFile = file: "[ -f ${file} ] && source ${file}";

  fullName = "Maas Lalani";
  email = "maaslalani1@gmail.com";
  githubHandle = "maaslalani";
in
  {
    home.packages = [
      pkgs.alacritty
      pkgs.bat
      pkgs.fortune
      pkgs.htop
      pkgs.pandoc
      pkgs.reattach-to-user-namespace
      pkgs.ripgrep
      pkgs.starship
      pkgs.texlive.combined.scheme-medium
      pkgs.tree
      pkgs.tmux
      pkgs.zsh
    ];

    programs.home-manager = {
      enable = true;
    };

    programs.alacritty = {
      enable = true;
      settings = import ./alacritty.nix;
    };

    programs.fzf = {
      enable = true;
    };

    programs.tmux = {
      enable = true;
      baseIndex = 1;
      disableConfirmationPrompt = true;
      escapeTime = 0;
      extraConfig = import ./tmux.nix;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      shortcut = "a";
      terminal = "xterm-256color";
      secureSocket = false;
    };

    programs.git = {
      enable = true;
      userName = fullName;
      userEmail = email;
      extraConfig = {
        github.user = githubHandle;
        credential.helper = "osxkeychain";
        diff.algorithm = "patience";
        protocol.version = "2";
        color.ui = true;
        pull.rebase = true;
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
    };

    programs.zsh = {
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
        ${sourceFile NIX_PATH}
        ${sourceFile DEV_PATH}
      '';
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.6.3";
            sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
            sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
          };
        }
      ];

      sessionVariables = rec {
        EDITOR = "vim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;
        GOPATH = "$HOME";
        FZF_DEFAULT_OPTS = "
        --color=fg:-1,bg:-1,hl:#88c0d0,fg+:#b48ead,bg+:#2e3440,hl+:#b48ead,info:#88c0d0
        --color=prompt:#88c0d0,pointer:#b48ead,marker:#b48ead,spinner:#81a1c1,header:#81a1c1
        ";
      };
    };

    programs.neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = import ./vim.nix;
      plugins = with pkgs.vimPlugins; [
        ale
        commentary
        fugitive
        fzf-vim
        nerdtree
        nord-vim
        polyglot
        repeat
        supertab
        surround
        vim-pandoc
      ];
    };
  }
