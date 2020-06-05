{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.coreutils
    pkgs.errcheck
    pkgs.exa
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fortune
    pkgs.go
    pkgs.golint
    pkgs.htop
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sops
    pkgs.spotify-tui
    pkgs.tree
    pkgs.yarn
    pkgs.zsh
  ];

  programs.alacritty.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.git.enable = true;
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.starship.enable = true;
  programs.tmux.enable = true;
  programs.z-lua.enable = true;

  programs.alacritty = {
    settings = import ./alacritty.nix;
  };

  programs.bat = {
    config = {
      theme = "Nord";
      pager = "less -RF";
    };
  };

  programs.git = {
    userName = "Maas Lalani";
    userEmail = "maaslalani1@gmail.com";
    extraConfig = {
      github.user = "maaslalani";
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      protocol.version = "2";
      color.ui = true;
      pull.rebase = true;
    };
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    extraConfig = import ./vim.nix;
    plugins = with pkgs.vimPlugins; [
      ale
      auto-pairs
      coc-nvim
      commentary
      emmet-vim
      fugitive
      fzf-vim
      gitgutter
      nord-vim
      polyglot
      supertab
      vim-dirvish
      vim-go
      vim-signature
      vim-test
    ];
  };

  programs.starship = {
    enableZshIntegration = true;
    settings = {
      kubernetes = {
        disabled = false;
      };
    };
  };

  programs.tmux = {
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = import ./tmux.nix;
    keyMode = "vi";
    secureSocket = false;
    shortcut = "a";
    terminal = "xterm-256color";
  };

  programs.zsh = import ./zsh.nix // {
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
  };
}
