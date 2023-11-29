{
  description = "home";

  inputs.helix.url = "github:helix-editor/helix/master";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  inputs.hammerspoon.url = "https://github.com/Hammerspoon/hammerspoon/releases/latest/download/Hammerspoon-0.9.100.zip";
  inputs.hammerspoon.flake = false;
  inputs.fnl.url = "path:fnl";
  inputs.fnl.flake = false;

  outputs = {self, home-manager, ...}@inputs: let
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
                cp $src/highlights.scm $out/highlights.scm
              '';
            };
          }
        )
      ];
  in {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./modules/hardware.nix
          ./modules/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.maas = {
              home.username = "maas";
              home.homeDirectory = "/home/maas";
              home.stateVersion = "23.11";

              programs.home-manager.enable = true;

              imports = [
                ./modules/git.nix
                ./modules/helix.nix
                ./modules/hyprland.nix
                ./modules/direnv.nix
                ./modules/fonts.nix
                ./modules/gh.nix
                ./modules/packages.nix
                ./modules/shell.nix
                ./modules/tmux.nix
                ./modules/kitty.nix
                ./modules/pass.nix
              ];
            };
          }
        ];
      };
    };

    homeConfigurations = {
      linux = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux // {inherit overlays;};
        modules = [
          ./modules/direnv.nix
          ./modules/fonts.nix
          ./modules/gh.nix
          ./modules/git.nix
          ./modules/helix.nix
          ./modules/hyprland.nix
          ./modules/packages.nix
          ./modules/shell.nix
          ./modules/tmux.nix
          ./modules/kitty.nix
          ./modules/pass.nix
          {
            home.username = "maas";
            home.stateVersion = "23.11";
            home.homeDirectory = "/home/maas";
          }
        ];
      };

      home = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs =
          inputs.nixpkgs.legacyPackages.aarch64-darwin
          // {
            inherit overlays;
            config = {
              permittedInsecurePackages = ["libxls-1.6.2"];
            };
          };
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
          ./modules/zellij.nix
          {
            home.username = "maas";
            home.stateVersion = "23.11";
            home.homeDirectory = "/Users/maas";
          }
        ];
      };
    };

    home = self.homeConfigurations.home.activationPackage;
    linux = self.homeConfigurations.linux.activationPackage;
  };
}
