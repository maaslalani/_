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
        handy = self.callPackage ./pkgs/handy.nix {};
        hunk = inputs.hunk.packages.${system}.default;
        moonside = self.callPackage ./pkgs/moonside.nix {};
        tmux = super.tmux.overrideAttrs (_: {
          version = "3.7";
          # The control-notify fix patched in for 3.6a is upstream as of 3.7.
          patches = [];
          src = self.fetchFromGitHub {
            owner = "tmux";
            repo = "tmux";
            tag = "3.7";
            hash = "sha256-dgqI1jZjnluN/F/AjngzcaMy3TgudmkvDT336YlhGZM=";
          };
        });
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
