{
  description = "home";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.home-manager = {
    url = "github:rycee/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
  {
    homeConfigurations = {
      home = inputs.home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, ... }:
        {
          nixpkgs.overlays = [
            inputs.neovim-nightly-overlay.overlay
          ];
          imports = [
            ./home.nix
          ];
        };
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
      };
    };
    home = self.homeConfigurations.home.activationPackage;
  };
}
