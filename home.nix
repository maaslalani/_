{ config, pkgs, ... }:

{
  home.packages = [
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
  ];

  programs.alacritty.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.git.enable = true;
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.tmux.enable = true;

  programs.alacritty = {
    settings = import ./alacritty.nix;
  };

  programs.bat = {
    config = {
      theme = "Nord";
      pager = "less -RF";
    };
  };

  programs.fzf = rec {
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--color=${builtins.concatStringsSep "," [
        "bg+:0" "fg+:5" "header:4" "hl+:5" "hl:6" "info:6"
        "marker:5" "pointer:5" "prompt:6" "spinner:4"
      ]}"
    ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--color=${builtins.concatStringsSep "," [
        "bg+:0" "fg+:5" "header:4" "hl+:5" "hl:6" "info:6"
        "marker:5" "pointer:5" "prompt:6" "spinner:4"
      ]}"
    ];
    enableZshIntegration = true;
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

  programs.tmux = {
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = import ./tmux.nix;
    secureSocket = false;
    shortcut = "a";
    terminal = "xterm-256color";
  };

  programs.zsh = import ./zsh.nix // {};
}
