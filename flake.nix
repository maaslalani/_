{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
  };

  outputs = inputs: let
    system = "aarch64-darwin";
    inherit (inputs.nixpkgs) lib;
    pkgs = inputs.nixpkgs.legacyPackages.${system}.extend (
      self: super: {
        mole = self.callPackage ./pkgs/mole.nix {};
      }
    );
    identity = {
      email = "maas@lalani.dev";
      name = "Maas Lalani";
      githubUser = "maaslalani";
      signingKey = "AECD51CD3C3A50BB9AA21C685A6ED5CBF1A0A000";
    };
    homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit identity;};
      modules = lib.mapAttrsToList (name: _: ./modules/${name}) (
        lib.filterAttrs (name: type: type == "directory" || lib.hasSuffix ".nix" name) (builtins.readDir ./modules)
      );
    };
  in {
    home = homeConfiguration.activationPackage;
    homeConfigurations.maas = homeConfiguration;
  };
}
