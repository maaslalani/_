{
  description = "home";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    fnl = { url = "path:fnl"; flake = false; };
    hammerspoon = {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.90/Hammerspoon-0.9.90.zip";
      flake = false;
    };

    awkward-nvim = { url = "github:maaslalani/awkward.nvim"; flake = false; };
    cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    cmp-luasnip = { url = "github:saadparwaiz1/cmp_luasnip"; flake = false; };
    cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
    fennel-vim = { url = "github:bakpakin/fennel.vim"; flake = false; };
    friendly-snippets = { url = "github:rafamadriz/friendly-snippets"; flake = false; };
    gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    hop-nvim = { url = "github:phaazon/hop.nvim"; flake = false; };
    luasnip = { url = "github:l3mon4d3/luasnip"; flake = false; };
    neorg-telescope = { url = "github:nvim-neorg/neorg-telescope"; flake = false; };
    neorg = { url = "github:nvim-neorg/neorg/unstable"; flake = false; };
    nordbuddy-nvim = { url = "github:maaslalani/nordbuddy"; flake = false; };
    nvim-autopairs = { url = "github:windwp/nvim-autopairs"; flake = false; };
    nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    popup-nvim = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    vim-commentary = { url = "github:tpope/vim-commentary"; flake = false; };
    vim-eunuch = { url = "github:tpope/vim-eunuch"; flake = false; };
    vim-fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
    vim-rails = { url = "github:tpope/vim-rails"; flake = false; };
    vim-rhubarb = { url = "github:tpope/vim-rhubarb"; flake = false; };
    vim-surround = { url = "github:tpope/vim-surround"; flake = false; };
    vim-test = { url = "github:vim-test/vim-test"; flake = false; };
    which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };
  };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; let
            plug = name: buildVimPluginFrom2Nix { pname = name; src = inputs.${name}; version = "unstable"; };
          in
            {
              awkward-nvim = plug "awkward-nvim";
              cmp-buffer = plug "cmp-buffer";
              cmp-luasnip = plug "cmp-luasnip";
              cmp-nvim-lsp = plug "cmp-nvim-lsp";
              cmp-path = plug "cmp-path";
              fennel-vim = plug "fennel-vim";
              friendly-snippets = plug "friendly-snippets";
              gitsigns-nvim = plug "gitsigns-nvim";
              hop-nvim = plug "hop-nvim";
              luasnip = plug "luasnip";
              neorg = plug "neorg";
              neorg-telescope = plug "neorg-telescope";
              nordbuddy-nvim = plug "nordbuddy-nvim";
              nvim-autopairs = plug "nvim-autopairs";
              nvim-cmp = plug "nvim-cmp";
              nvim-lspconfig = plug "nvim-lspconfig";
              nvim-treesitter = plug "nvim-treesitter";
              plenary-nvim = plug "plenary-nvim";
              popup-nvim = plug "popup-nvim";
              telescope-nvim = plug "telescope-nvim";
              vim-commentary = plug "vim-commentary";
              vim-eunuch = plug "vim-eunuch";
              vim-fugitive = plug "vim-fugitive";
              vim-rails = plug "vim-rails";
              vim-rhubarb = plug "vim-rhubarb";
              vim-surround = plug "vim-surround";
              vim-test = plug "vim-test";
              which-key-nvim = plug "which-key-nvim";

              hammerspoon = self.pkgs.stdenv.mkDerivation {
                pname = "hammerspoon";
                version = "0.9.90";
                src = inputs.hammerspoon;
                buildInputs = [ self.pkgs.fennel ];
                installPhase = ''
                  mkdir -p $out/Applications/Hammerspoon.app
                  cp -r $src/Contents $out/Applications/Hammerspoon.app/
                '';
              };

              fnl = self.pkgs.stdenv.mkDerivation {
                pname = "fnl";
                version = "unstable";
                src = inputs.fnl;
                buildInputs = [ self.pkgs.fennel ];
                installPhase = ''
                  mkdir -p $out
                  fennel --compile $src/init.fnl > $out/init.lua
                  fennel --compile $src/hammerspoon.fnl > $out/hammerspoon.lua
                '';
              };
            }
        )
        inputs.neovim-nightly-overlay.overlay
      ];
      spin = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/spin";
        username = "spin";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays ++ [
            (self: super: { unstable = inputs.nixpkgs.legacyPackages.x86_64-linux; })
          ];
          imports = [
            ./modules/core.nix
            ./modules/fzf.nix
            ./modules/shell.nix
            ./modules/tmux.nix
            ./modules/vim.nix
          ];
        };
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays ++ [
            (self: super: { unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin; })
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fonts.nix
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix
            ./modules/hammerspoon.nix
            ./modules/packages.nix
            ./modules/pass.nix
            ./modules/shell.nix
            ./modules/spotify.nix
            ./modules/tmux.nix
            ./modules/vim.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    spin = self.homeConfigurations.spin.activationPackage;
  };
}
