{
  inputs.helix.url = "github:helix-editor/helix/master";
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
        moonside = self.callPackage ./pkgs/moonside.nix {};
      }
    );
  in {
    packages.${system}.moonside = pkgs.moonside;

    home =
      (inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = map (f: ./modules/${f}) (builtins.attrNames (builtins.readDir ./modules));
      }).activationPackage;
  };
}
