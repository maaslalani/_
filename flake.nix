{
  description = "home";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  /* Neovim Plugins */
  inputs.colorbuddy-nvim = { url = "github:tjdevries/colorbuddy.nvim"; flake = false; };
  inputs.gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
  inputs.nordbuddy-nvim = { url = "github:maaslalani/nordbuddy"; flake = false; };
  inputs.nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
  inputs.pears-nvim = { url = "github:steelsojka/pears.nvim"; flake = false; };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; {
            colorbuddy-nvim = buildVimPluginFrom2Nix { name = "colorbuddy"; src = inputs.colorbuddy-nvim; };
            gitsigns-nvim = buildVimPluginFrom2Nix { name = "gitsigns"; src = inputs.gitsigns-nvim; };
            nordbuddy-nvim = buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy-nvim; };
            nvim-treesitter = buildVimPluginFrom2Nix { name = "nvim-treesitter"; src = inputs.nvim-treesitter; };
            pears-nvim = buildVimPluginFrom2Nix { name = "pears-nvim"; src = inputs.pears-nvim; };
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
            ./modules/gh.nix
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
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix
            ./modules/packages.nix
            ./modules/shell.nix
            ./modules/skhd.nix
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
