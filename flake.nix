{
  description = "home";

  inputs = {
    helix.url = "github:helix-editor/helix/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    hammerspoon = {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/latest/download/Hammerspoon-0.9.100.zip";
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
              version = "unstable";
              src = inputs.hammerspoon;
              installPhase = ''
                mkdir -p $out/Applications/Hammerspoon.app
                cp -r $src/Contents $out/Applications/Hammerspoon.app/
              '';
            };

            helix = inputs.helix.packages.${self.system}.default;

            fnl = self.pkgs.stdenv.mkDerivation {
              pname = "fnl";
              version = "unstable";
              src = inputs.fnl;
              buildInputs = [self.pkgs.fennel];
              installPhase = ''
                mkdir -p $out
                fennel --compile $src/hammerspoon.fnl > $out/hammerspoon.lua
                fennel --compile $src/init.fnl > $out/init.lua
              '';
            };
          }
        )
      ];
      linux = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux // {inherit overlays;};
        modules = [
          ./modules/direnv.nix
          ./modules/helix.nix
          ./modules/packages.nix
          ./modules/shell.nix
          ./modules/tmux.nix
          {
            home = {
              homeDirectory = "/home/maas";
              stateVersion = "22.11";
              username = "maas";
            };
          }
        ];
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin // {inherit overlays;};
        modules = [
          ./modules/direnv.nix
          ./modules/fonts.nix
          ./modules/gh.nix
          ./modules/ghostty.nix
          ./modules/git.nix
          ./modules/hammerspoon.nix
          ./modules/helix.nix
          ./modules/kitty.nix
          ./modules/packages.nix
          ./modules/pass.nix
          ./modules/scim.nix
          ./modules/shell.nix
          ./modules/spotify.nix
          ./modules/tmux.nix
          ./modules/vim.nix
          {
            home = {
              homeDirectory = "/Users/maas";
              stateVersion = "22.11";
              username = "maas";
            };
          }
        ];
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    linux = self.homeConfigurations.linux.activationPackage;
  };
}
