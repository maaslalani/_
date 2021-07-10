{
  description = "home";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  /* Neovim Plugins */
  inputs.gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
  inputs.neorg = { url = "github:vhyrro/neorg/unstable"; flake = false; };
  inputs.nordbuddy-nvim = { url = "github:maaslalani/nordbuddy/hop"; flake = false; };
  inputs.nvim-compe = { url = "github:hrsh7th/nvim-compe"; flake = false; };
  inputs.nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
  inputs.plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
  inputs.telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
  inputs.which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; {
            gitsigns-nvim = buildVimPluginFrom2Nix { name = "gitsigns"; src = inputs.gitsigns-nvim; };
            neorg = buildVimPluginFrom2Nix { name = "neorg"; src = inputs.neorg; };
            nordbuddy-nvim = buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy-nvim; };
            nvim-compe = buildVimPluginFrom2Nix { name = "nvim-compe"; src = inputs.nvim-compe; };
            nvim-treesitter = buildVimPluginFrom2Nix { name = "nvim-treesitter"; src = inputs.nvim-treesitter; };
            plenary-nvim = buildVimPluginFrom2Nix { name = "plenary-nvim"; src = inputs.plenary-nvim; };
            telescope-nvim = buildVimPluginFrom2Nix { name = "telescope"; src = inputs.telescope-nvim; };
            which-key-nvim = buildVimPluginFrom2Nix { name = "which-key-nvim"; src = inputs.which-key-nvim; };
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
            (
              self: super: {
                unstable = inputs.nixpkgs.legacyPackages.x86_64-linux;
              }
            )
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
            (
              self: super: {
                unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin;
              }
            )
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fonts.nix
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix
            ./modules/packages.nix
            ./modules/pass.nix
            ./modules/shell.nix
            ./modules/skhd.nix
            ./modules/spotify.nix
            ./modules/tmux.nix
            ./modules/vim.nix
            ./modules/yabai.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    spin = self.homeConfigurations.spin.activationPackage;
  };
}
