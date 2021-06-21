{
  description = "home";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  /* Neovim Plugins */
  inputs.aniseed = { url = "github:olical/aniseed"; flake = false; };
  inputs.completion-nvim = { url = "github:nvim-lua/completion-nvim"; flake = false; };
  inputs.conjure = { url = "github:Olical/conjure"; flake = false; };
  inputs.gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
  inputs.lua-snip = { url = "github:l3mon4d3/luasnip"; flake = false; };
  inputs.neorg = { url = "github:vhyrro/neorg"; flake = false; };
  inputs.nordbuddy-nvim = { url = "github:maaslalani/nordbuddy"; flake = false; };
  inputs.nvim-dap = { url = "github:mfussenegger/nvim-dap"; flake = false; };
  inputs.nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
  inputs.plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
  inputs.telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
  inputs.vim-test = { url = "github:vim-test/vim-test"; flake = false; };
  inputs.which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; {
            aniseed = buildVimPluginFrom2Nix { name = "aniseed"; src = inputs.aniseed; };
            completion-nvim = buildVimPluginFrom2Nix { name = "completion-nvim"; src = inputs.completion-nvim; };
            conjure = buildVimPluginFrom2Nix { name = "conjure"; src = inputs.conjure; };
            gitsigns-nvim = buildVimPluginFrom2Nix { name = "gitsigns"; src = inputs.gitsigns-nvim; };
            lua-snip = buildVimPluginFrom2Nix { name = "lua-snip"; src = inputs.lua-snip; };
            neorg = buildVimPluginFrom2Nix { name = "neorg"; src = inputs.neorg; };
            nordbuddy-nvim = buildVimPluginFrom2Nix { name = "nordbuddy"; src = inputs.nordbuddy-nvim; };
            nvim-dap = buildVimPluginFrom2Nix { name = "nvim-dap"; src = inputs.nvim-dap; };
            nvim-treesitter = buildVimPluginFrom2Nix { name = "nvim-treesitter"; src = inputs.nvim-treesitter; };
            plenary-nvim = buildVimPluginFrom2Nix { name = "plenary-nvim"; src = inputs.plenary-nvim; };
            telescope-nvim = buildVimPluginFrom2Nix { name = "telescope"; src = inputs.telescope-nvim; };
            vim-test = buildVimPluginFrom2Nix { name = "vim-test"; src = inputs.vim-test; };
            which-key-nvim = buildVimPluginFrom2Nix { name = "which-key-nvim"; src = inputs.which-key-nvim; };
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
            (
              self: super: {
                unstable = inputs.nixpkgs.legacyPackages.x86_64-linux;
              }
            )
          ];
          imports = [
            ./modules/core.nix
            ./modules/fzf.nix
            ./modules/gh.nix
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
            (
              self: super: {
                unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin;
              }
            )
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fonts.nix
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix
            ./modules/packages.nix
            ./modules/pass.nix
            ./modules/shell.nix
            ./modules/skhd.nix
            ./modules/spotify.nix
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
