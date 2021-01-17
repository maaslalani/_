{
  description = "home";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  /* Neovim Plugins */
  inputs.colorbuddy = { url = "github:tjdevries/colorbuddy.nvim"; flake = false; };
  inputs.nordbuddy = { url = "github:maaslalani/nordbuddy"; flake = false; };
  inputs.treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };

  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = [
            (
              self: super: with self.vimUtils; {
                colorbuddy = buildVimPluginFrom2Nix { name = "colorbuddy"; src = inputs.colorbuddy; };
                nordbuddy = buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy; };
                treesitter = buildVimPluginFrom2Nix { name = "treesitter"; src = inputs.treesitter; };
                unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin;
              }
            )
            inputs.neovim-nightly-overlay.overlay
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fzf.nix
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
  };
}
