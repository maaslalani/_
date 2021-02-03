{
  description = "home";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  /* Neovim Plugins */
  inputs.colorbuddy-nvim = { url = "github:tjdevries/colorbuddy.nvim"; flake = false; };
  inputs.nordbuddy-nvim = { url = "github:maaslalani/nordbuddy"; flake = false; };
  inputs.neuron-nvim = { url = "github:oberblastmeister/neuron.nvim"; flake = false; };


  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      spin = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/spin";
        username = "spin";
        configuration = { pkgs, ... }: {
          imports = [
            ./modules/shell.nix
            ./modules/tmux.nix
          ];
        };
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = [
            (
              self: super: with self.vimUtils; {
                colorbuddy-nvim = buildVimPluginFrom2Nix { name = "colorbuddy"; src = inputs.colorbuddy-nvim; };
                nordbuddy-nvim = buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy-nvim; };
                neuron-nvim = buildVimPluginFrom2Nix { name = "neuron"; src = inputs.neuron-nvim; };
                unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin;
              }
            )
            inputs.neovim-nightly-overlay.overlay
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fzf.nix
            ./modules/git.nix
            ./modules/packages.nix
            ./modules/shell.nix
            ./modules/skhd.nix
            ./modules/tmux.nix
            ./modules/vim.nix
            ./modules/yabai.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    spin = self.homeConfigurations.spin.activationPackage;
  };
}
