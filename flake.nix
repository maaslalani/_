{
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;

    system = "aarch64-darwin";
    pkgs = inputs.nixpkgs.legacyPackages.${system};

    homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        colors = import ./colors.nix;
        identity = import ./identity.nix;
      };
      modules = lib.mapAttrsToList (name: _: ./modules/${name}) (
        lib.filterAttrs (name: type: type == "directory" || lib.hasSuffix ".nix" name) (builtins.readDir ./modules)
      );
    };
  in {
    checks.${system}.stamp = import ./tests/stamp.nix {inherit pkgs;};
    home = homeConfiguration.activationPackage;
    homeConfigurations.maas = homeConfiguration;
  };
}
