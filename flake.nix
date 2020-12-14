{
  description = "home";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.home-manager.url = "github:rycee/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = [
            inputs.neovim-nightly-overlay.overlay
          ];
          imports = [
            ./editor/vim.nix
            ./modules/alacritty.nix
            ./modules/fzf.nix
            ./modules/git.nix
            ./modules/tmux.nix
            ./modules/zsh.nix
            ./modules/packages.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
  };
}
