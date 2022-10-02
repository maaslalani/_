{
  description = "home";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/master";

    helix = {
      url = "github:helix-editor/helix";
      flake = true;
    };
    hammerspoon = {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/latest/download/Hammerspoon-0.9.97.zip";
      flake = false;
    };
    fnl = {
      url = "path:fnl";
      flake = false;
    };
  };

  outputs = {self, ...} @ inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: {
            hammerspoon = self.pkgs.stdenv.mkDerivation {
              pname = "hammerspoon";
              version = "0.9.97";
              src = inputs.hammerspoon;
              installPhase = ''
                mkdir -p $out/Applications/Hammerspoon.app
                cp -r $src/Contents $out/Applications/Hammerspoon.app/
              '';
            };

            fnl = self.pkgs.stdenv.mkDerivation {
              pname = "fnl";
              version = "unstable";
              src = inputs.fnl;
              buildInputs = [self.pkgs.fennel];
              installPhase = ''
                mkdir -p $out
                fennel --compile $src/hammerspoon.fnl > $out/hammerspoon.lua
              '';
            };
          }
        )
      ];
      linux = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux // {inherit overlays;};
        modules = [
          ./modules/linux.nix
          ./modules/packages.nix
          ./modules/shell.nix
          ./modules/tmux.nix
          ./modules/helix.nix
        ];
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin // {inherit overlays;};
        modules = [
          ./modules/fonts.nix
          ./modules/gh.nix
          ./modules/git.nix
          ./modules/hammerspoon.nix
          ./modules/home.nix
          ./modules/kitty.nix
          ./modules/packages.nix
          ./modules/pass.nix
          ./modules/scim.nix
          ./modules/shell.nix
          ./modules/spotify.nix
          ./modules/tmux.nix
          ./modules/helix.nix
        ];
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    linux = self.homeConfigurations.linux.activationPackage;
  };
}
