{
  description = "home";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nordic-nvim = { url = "github:andersevenrud/nordic.nvim"; flake = false; };
    fnl = { url = "path:fnl"; flake = false; };
    hammerspoon = {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/latest/download/Hammerspoon-0.9.93.zip";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; let
            plug = name: buildVimPluginFrom2Nix { pname = name; src = inputs.${name}; version = "unstable"; };
          in
          {
            nordic-nvim = plug "nordic-nvim";

            hammerspoon = self.pkgs.stdenv.mkDerivation {
              pname = "hammerspoon";
              version = "0.9.93";
              src = inputs.hammerspoon;
              installPhase = ''
                mkdir -p $out/Applications/Hammerspoon.app
                cp -r $src/Contents $out/Applications/Hammerspoon.app/
                ln -sf $out/Applications/Hammerspoon.app/ /Applications/
              '';
            };

            fnl = self.pkgs.stdenv.mkDerivation {
              pname = "fnl";
              version = "unstable";
              src = inputs.fnl;
              buildInputs = [ self.pkgs.fennel ];
              installPhase = ''
                mkdir -p $out
                fennel --compile $src/init.fnl > $out/init.lua
                fennel --compile $src/hammerspoon.fnl > $out/hammerspoon.lua
              '';
            };
          }
        )
        inputs.neovim-nightly-overlay.overlay
      ];
      spin = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/spin";
        username = "spin";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays ++ [
            (self: super: { unstable = inputs.nixpkgs.legacyPackages.x86_64-linux; })
          ];
          imports = [
            ./modules/fzf.nix
            ./modules/packages.nix
            ./modules/shell.nix
            ./modules/tmux.nix
            ./modules/vim.nix
          ];
        };
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays ++ [
            (self: super: { unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin; })
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fonts.nix
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix
            ./modules/hammerspoon.nix
            ./modules/kitty.nix
            ./modules/packages.nix
            ./modules/scim.nix
            ./modules/shell.nix
            ./modules/spotify.nix
            ./modules/tmux.nix
            ./modules/vim.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    spin = self.homeConfigurations.spin.activationPackage;
  };
}
