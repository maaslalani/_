{ config, pkgs, ... }:

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
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
    initExtraBeforeCompInit = ''
      eval $(${pkgs.starship}/bin/starship init zsh)
    '';
    initExtra = builtins.readFile ./init.zsh;
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
      NVIM_TUI_ENABLE_TRUE_COLOR = "1";
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
      DEV_ALLOW_ITERM2_INTEGRATION = "1";
      EDITOR = "vim";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;
      GOPATH = "$HOME";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config.vim;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-ruby
      vim-go
      vim-fish
      rust-vim
      nord-vim
      lightline-vim
      vim-surround
      vim-repeat
      vim-commentary
      vim-sneak
      supertab
      ale
      nerdtree
      vim-fugitive
    ];
  };
}
