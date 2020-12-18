{
  description = "home";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.home-manager.url = "github:rycee/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  /* Neovim Plugins */
  inputs.nordbuddy  = { url = "github:maaslalani/nordbuddy"; flake = false; };
  inputs.telescope  = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
  inputs.popup      = { url =  "github:nvim-lua/popup.nvim"; flake = false; };
  inputs.plenary    = { url =  "github:nvim-lua/plenary.nvim"; flake = false; };
  inputs.colorbuddy = { url =  "github:tjdevries/colorbuddy.nvim"; flake = false; };
  inputs.treesitter = { url =  "github:nvim-treesitter/nvim-treesitter"; flake = false; };

  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = [
          (self: super: with self.vimUtils; {
             nordbuddy  = buildVimPluginFrom2Nix { name = "nordbuddy";  src = inputs.nordbuddy; };
             telescope  = buildVimPluginFrom2Nix { name = "telescope";  src = inputs.telescope; };
             popup      = buildVimPluginFrom2Nix { name = "popup";      src = inputs.popup; };
             plenary    = buildVimPluginFrom2Nix { name = "plenary";    src = inputs.plenary; };
             colorbuddy = buildVimPluginFrom2Nix { name = "colorbuddy"; src = inputs.colorbuddy; };
             treesitter = buildVimPluginFrom2Nix { name = "treesitter"; src = inputs.treesitter; };
           })
          inputs.neovim-nightly-overlay.overlay
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
