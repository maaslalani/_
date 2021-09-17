{
  description = "home";

  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.awkward-nvim = { url = "github:maaslalani/awkward.nvim"; flake = false; };
  inputs.cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
  inputs.cmp-luasnip = { url = "github:saadparwaiz1/cmp_luasnip"; flake = false; };
  inputs.cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
  inputs.cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
  inputs.gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
  inputs.luasnip = { url = "github:l3mon4d3/luasnip"; flake = false; };
  inputs.neorg = { url = "github:nvim-neorg/neorg/unstable"; flake = false; };
  inputs.neorg-telescope = { url = "github:nvim-neorg/neorg-telescope"; flake = false; };
  inputs.nordbuddy-nvim = { url = "github:maaslalani/nordbuddy"; flake = false; };
  inputs.nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
  inputs.nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
  inputs.plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
  inputs.telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
  inputs.which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

  inputs.fnl = { url = "path:fnl"; flake = false; };

  inputs.hammerspoon = {
    url = "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.90/Hammerspoon-0.9.90.zip";
    flake = false;
  };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; {
            awkward-nvim = buildVimPluginFrom2Nix { pname = "awkward"; src = inputs.awkward-nvim; version = "unstable"; };
            cmp-buffer = buildVimPluginFrom2Nix { pname = "cmp-buffer"; src = inputs.cmp-buffer; version = "unstable"; };
            cmp-luasnip = buildVimPluginFrom2Nix { pname = "cmp-luasnip"; src = inputs.cmp-luasnip; version = "unstable"; };
            cmp-nvim-lsp = buildVimPluginFrom2Nix { pname = "cmp-nvim-lsp"; src = inputs.cmp-nvim-lsp; version = "unstable"; };
            cmp-path = buildVimPluginFrom2Nix { pname = "cmp-path"; src = inputs.cmp-path; version = "unstable"; };
            gitsigns-nvim = buildVimPluginFrom2Nix { pname = "gitsigns"; src = inputs.gitsigns-nvim; version = "unstable"; };
            luasnip = buildVimPluginFrom2Nix { pname = "luasnip"; src = inputs.luasnip; version = "unstable"; };
            neorg = buildVimPluginFrom2Nix { pname = "neorg"; src = inputs.neorg; version = "unstable"; };
            neorg-telescope = buildVimPluginFrom2Nix { pname = "neorg-telescope"; src = inputs.neorg-telescope; version = "unstable"; };
            nordbuddy-nvim = buildVimPluginFrom2Nix { pname = "nordbuddy"; src = inputs.nordbuddy-nvim; version = "unstable"; };
            nvim-cmp = buildVimPluginFrom2Nix { pname = "nvim-cmp"; src = inputs.nvim-cmp; version = "unstable"; };
            nvim-treesitter = buildVimPluginFrom2Nix { pname = "nvim-treesitter"; src = inputs.nvim-treesitter; version = "unstable"; };
            plenary-nvim = buildVimPluginFrom2Nix { pname = "plenary-nvim"; src = inputs.plenary-nvim; version = "unstable"; };
            telescope-nvim = buildVimPluginFrom2Nix { pname = "telescope"; src = inputs.telescope-nvim; version = "unstable"; };
            which-key-nvim = buildVimPluginFrom2Nix { pname = "which-key-nvim"; src = inputs.which-key-nvim; version = "unstable"; };

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
              version = "0.0.1";
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
