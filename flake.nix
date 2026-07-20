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
    pkgs = inputs.nixpkgs.legacyPackages.${system}.extend (
      self: super: {
        mole = self.callPackage ./pkgs/mole.nix {};
      }
    );
    identity = {
      email = "maas@lalani.dev";
      name = "Maas Lalani";
      githubUser = "maaslalani";
    };
    homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit identity;};
      modules = map (f: ./modules/${f}) (builtins.attrNames (builtins.readDir ./modules));
    };
  in {
    home = homeConfiguration.activationPackage;
    homeConfigurations.maas = homeConfiguration;
  };
}
