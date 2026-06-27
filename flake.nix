{
  inputs.hunk.url = "github:modem-dev/hunk";
  inputs.hunk.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs: let
    system = "aarch64-darwin";
    pkgs = inputs.nixpkgs.legacyPackages.${system}.extend (
      self: super: {
        diagon = self.callPackage ./pkgs/diagon.nix {};
        gws = self.callPackage ./pkgs/gws.nix {};
        handy = self.callPackage ./pkgs/handy.nix {};
        hunk = inputs.hunk.packages.${system}.default;
        moonside = self.callPackage ./pkgs/moonside.nix {};
        tuistory = self.callPackage ./pkgs/tuistory.nix {};
      }
    );
    identity = {
      email = "maas@lalani.dev";
      name = "Maas Lalani";
      githubUser = "maaslalani";
    };
  in {
    packages.${system}.moonside = pkgs.moonside;

    home =
      (inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit identity;};
        modules = map (f: ./modules/${f}) (builtins.attrNames (builtins.readDir ./modules));
      }).activationPackage;
  };
}
