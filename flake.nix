{
  description = "home";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager/99f0074";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  /* Neovim Plugins */
  inputs.colorbuddy = { url = "github:tjdevries/colorbuddy.nvim"; flake = false; };
  inputs.nordbuddy = { url = "github:maaslalani/nordbuddy"; flake = false; };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        (
          self: super: {
            colorbuddy = self.vimUtils.buildVimPluginFrom2Nix { name = "colorbuddy"; src = inputs.colorbuddy; };
            nordbuddy = self.vimUtils.buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy; };
            unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin;
          }
        )
        inputs.neovim-nightly-overlay.overlay
      ];
    in
      {
        homeConfigurations = {
          home = inputs.home-manager.lib.homeManagerConfiguration {
            system = "x86_64-darwin";
            homeDirectory = "/Users/maas";
            username = "maas";
            configuration = { pkgs, ... }: {
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/alacritty.nix
                ./modules/fzf.nix
                ./modules/git.nix
                ./modules/packages.nix
                ./modules/tmux.nix
                ./modules/vim.nix
                ./modules/shell.nix
              ];
            };
          };
        };
        home = self.homeConfigurations.home.activationPackage;
      };
}
