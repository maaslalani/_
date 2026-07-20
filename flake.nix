{
  inputs.hunk.url = "github:modem-dev/hunk/main";
  inputs.hunk.inputs.nixpkgs.follows = "nixpkgs";
  inputs.hunk.inputs.bun2nix.inputs.systems.url = "github:nix-systems/aarch64-darwin";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs: let
    system = "aarch64-darwin";
    pkgs = inputs.nixpkgs.legacyPackages.${system}.extend (
      self: super: {
        hunk = inputs.hunk.packages.${system}.default;
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
