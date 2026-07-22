{
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = inputs: let
    system = "aarch64-darwin";
    inherit (inputs.nixpkgs) lib;
    pkgs = inputs.nixpkgs.legacyPackages.${system};

    identity = {
      email = "maas@lalani.dev";
      name = "Maas Lalani";
      githubUser = "maaslalani";
      signingKey = "AECD51CD3C3A50BB9AA21C685A6ED5CBF1A0A000";
    };
    colors = {
      primary = {
        background = "#0D1116";
        foreground = "#C5C8C6";
      };

      separator = "#5a636e";

      normal = {
        black = "#282a2e";
        red = "#D74E6F";
        green = "#31BB71";
        yellow = "#D3E561";
        blue = "#8056FF";
        magenta = "#ED61D7";
        cyan = "#04D7D7";
        white = "#C5C8C6";
      };

      bright = {
        black = "#4B4B4B";
        red = "#FE5F86";
        green = "#00D787";
        yellow = "#EBFF71";
        blue = "#8F69FF";
        magenta = "#FF7AEA";
        cyan = "#00FEFE";
        white = "#FFFFFF";
      };

      tmux = {
        paneBorder = "#1a1b26";
        popupBorder = "#b9bcb9";
        statusAccent = "#7879a6";
        statusUser = "#515170";
        statusDim = "#44445e";
        windowInactive = "#58587a";
        messageFg = "#fcfcfc";
        modeBg = "#273457";
      };
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
