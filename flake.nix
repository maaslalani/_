{
  description = "home";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.home-manager.url = "github:rycee/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      home = inputs.home-manager.lib.homeManagerConfiguration {
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
          ];
          programs.bat.enable = true;
          programs.home-manager.enable = true;
          programs.taskwarrior.enable = true;
          programs.z-lua.enable = true;
          home.packages = [
            pkgs.cachix
            pkgs.coreutils
            pkgs.docker
            pkgs.errcheck
            pkgs.exa
            pkgs.fd
            pkgs.ffmpeg
            pkgs.git
            pkgs.glow
            pkgs.gnupg
            pkgs.go
            pkgs.google-cloud-sdk
            pkgs.htop
            pkgs.jq
            pkgs.kubectl
            pkgs.nodejs
            pkgs.pass
            pkgs.ripgrep
            pkgs.rustup
            pkgs.sops
            pkgs.tree
            pkgs.vault
            pkgs.yarn
          ] ++ [
            pkgs.gopls
            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.nodePackages.bash-language-server
            pkgs.nodePackages.dockerfile-language-server-nodejs
            pkgs.rnix-lsp
            pkgs.solargraph
          ];
        };
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
      };
    };
    home = self.homeConfigurations.home.activationPackage;
  };
}
