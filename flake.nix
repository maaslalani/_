{
  description = "home";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.home-manager.url = "github:rycee/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";


  /* Neovim Plugins */
  inputs.nordbuddy.url = "github:maaslalani/nordbuddy";
  inputs.telescope.url = "github:nvim-telescope/telescope.nvim";
  inputs.popup.url = "github:nvim-lua/popup.nvim";
  inputs.plenary.url = "github:nvim-lua/plenary.nvim";
  inputs.colorbuddy.url = "github:tjdevries/colorbuddy.nvim";
  inputs.treesitter.url = "github:nvim-treesitter/nvim-treesitter";
  inputs.nordbuddy.flake = false;
  inputs.telescope.flake = false;
  inputs.popup.flake = false;
  inputs.plenary.flake = false;
  inputs.colorbuddy.flake = false;
  inputs.treesitter.flake = false;

  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = [
            inputs.neovim-nightly-overlay.overlay
            (self: super: {
               nordbuddy = self.vimUtils.buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy; };
               telescope = self.vimUtils.buildVimPluginFrom2Nix { name = "telescope"; src = inputs.telescope; };
               popup = self.vimUtils.buildVimPluginFrom2Nix { name = "popup"; src = inputs.popup; };
               plenary = self.vimUtils.buildVimPluginFrom2Nix { name = "plenary"; src = inputs.plenary; };
               colorbuddy = self.vimUtils.buildVimPluginFrom2Nix { name = "colorbuddy"; src = inputs.colorbuddy; };
               treesitter = self.vimUtils.buildVimPluginFrom2Nix { name = "treesitter"; src = inputs.treesitter; };
             })
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fzf.nix
            ./modules/git.nix
            ./modules/packages.nix
            ./modules/tmux.nix
            ./modules/vim.nix
            ./modules/zsh.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
  };
}
