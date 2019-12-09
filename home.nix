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
    pkgs.bat
    pkgs.fortune
    pkgs.git
    pkgs.htop
    pkgs.ripgrep
    pkgs.starship
    pkgs.tree
    pkgs.zsh
  ];

  programs.home-manager = {
    enable = true;
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
      NVIM_TUI_ENABLE_TRUE_COLOR = "1";
      GOPATH = "$HOME";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config.vim;
    plugins = with pkgs.vimPlugins; [
      ale
      lightline-vim
      nerdtree
      nord-vim
      supertab
      vim-commentary
      vim-fugitive
      vim-repeat
      vim-polyglot
      vim-surround
    ];
  };
}
