{
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;

    system = "aarch64-darwin";
    pkgs = inputs.nixpkgs.legacyPackages.${system};

    identity = {
      email = "maas@lalani.dev";
      name = "Maas Lalani";
      githubUser = "maaslalani";
      signingKey = "AECD51CD3C3A50BB9AA21C685A6ED5CBF1A0A000";
    };

    colors = {
      primary.background = "#0D1116";
      primary.foreground = "#C5C8C6";

      separator = "#5a636e";

      normal.black = "#282a2e";
      normal.red = "#D74E6F";
      normal.green = "#31BB71";
      normal.yellow = "#D3E561";
      normal.blue = "#8056FF";
      normal.magenta = "#ED61D7";
      normal.cyan = "#04D7D7";
      normal.white = "#C5C8C6";

      bright.black = "#4B4B4B";
      bright.red = "#FE5F86";
      bright.green = "#00D787";
      bright.yellow = "#EBFF71";
      bright.blue = "#8F69FF";
      bright.magenta = "#FF7AEA";
      bright.cyan = "#00FEFE";
      bright.white = "#FFFFFF";
    };
    homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit identity colors;};
      modules = lib.mapAttrsToList (name: _: ./modules/${name}) (
        lib.filterAttrs (name: type: type == "directory" || lib.hasSuffix ".nix" name) (builtins.readDir ./modules)
      );
    };
  in {
    home = homeConfiguration.activationPackage;
    homeConfigurations.maas = homeConfiguration;
  };
}
