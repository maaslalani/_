{
  description = "home";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/master";

    cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    cmp-luasnip = { url = "github:saadparwaiz1/cmp_luasnip"; flake = false; };
    cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
    copilot-vim = { url = "github:github/copilot.vim"; flake = false; };
    friendly-snippets = { url = "github:rafamadriz/friendly-snippets"; flake = false; };
    gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    hop-nvim = { url = "github:phaazon/hop.nvim"; flake = false; };
    luasnip = { url = "github:l3mon4d3/luasnip"; flake = false; };
    null-ls-nvim = { url = "github:jose-elias-alvarez/null-ls.nvim"; flake = false; };
    nvim-autopairs = { url = "github:windwp/nvim-autopairs"; flake = false; };
    nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    nvim-neorg = { url = "github:nvim-neorg/neorg"; flake = false; };
    nvim-spellsitter = { url = "github:lewis6991/spellsitter.nvim"; flake = false; };
    nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    nvim-treesitter-playground = { url = "github:nvim-treesitter/playground"; flake = false; };
    plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    popup-nvim = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    vim-commentary = { url = "github:tpope/vim-commentary"; flake = false; };
    vim-fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
    vim-hexokinase = { url = "github:rrethy/vim-hexokinase"; flake = false; };
    vim-rhubarb = { url = "github:tpope/vim-rhubarb"; flake = false; };
    vim-sleuth = { url = "github:tpope/vim-sleuth"; flake = false; };
    vim-surround = { url = "github:tpope/vim-surround"; flake = false; };
    vim-test = { url = "github:vim-test/vim-test"; flake = false; };
    which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

    fnl = { url = "path:fnl"; flake = false; };
    saturn = { url = "path:colors"; flake = false; };
  };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils;
          let
            plug = name: buildVimPluginFrom2Nix {
              pname = name;
              src = inputs.${name};
              version = "unstable";
            };
          in
          {
            cmp-buffer = plug "cmp-buffer";
            cmp-luasnip = plug "cmp-luasnip";
            cmp-nvim-lsp = plug "cmp-nvim-lsp";
            cmp-path = plug "cmp-path";
            copilot-vim = plug "copilot-vim";
            friendly-snippets = plug "friendly-snippets";
            gitsigns-nvim = plug "gitsigns-nvim";
            hop-nvim = plug "hop-nvim";
            luasnip = plug "luasnip";
            null-ls-nvim = plug "null-ls-nvim";
            nvim-autopairs = plug "nvim-autopairs";
            nvim-cmp = plug "nvim-cmp";
            nvim-lspconfig = plug "nvim-lspconfig";
            nvim-neorg = plug "nvim-neorg";
            nvim-spellsitter = plug "nvim-spellsitter";
            nvim-treesitter = plug "nvim-treesitter";
            nvim-treesitter-playground = plug "nvim-treesitter-playground";
            plenary-nvim = plug "plenary-nvim";
            popup-nvim = plug "popup-nvim";
            telescope-nvim = plug "telescope-nvim";
            vim-commentary = plug "vim-commentary";
            vim-fugitive = plug "vim-fugitive";
            vim-hexokinase = plug "vim-hexokinase";
            vim-rhubarb = plug "vim-rhubarb";
            vim-sleuth = plug "vim-sleuth";
            vim-surround = plug "vim-surround";
            vim-test = plug "vim-test";
            which-key-nvim = plug "which-key-nvim";

            fnl = self.pkgs.stdenv.mkDerivation {
              pname = "fnl";
              version = "unstable";
              src = inputs.fnl;
              buildInputs = [ self.pkgs.fennel ];
              installPhase = ''
                mkdir -p $out
                fennel --compile $src/init.fnl > $out/init.lua
              '';
            };

            saturn = self.pkgs.stdenv.mkDerivation {
              pname = "saturn";
              version = "unstable";
              src = inputs.saturn;
              installPhase = ''
                mkdir -p $out
                cp $src/saturn.vim $out/saturn.vim
              '';
            };
          }
        )
        inputs.neovim-nightly-overlay.overlay
      ];
      linux = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux // { inherit overlays; };
        modules = [
          ./modules/linux.nix
          ./modules/fzf.nix
          ./modules/packages.nix
          ./modules/shell.nix
          ./modules/tmux.nix
          ./modules/vim.nix
        ];
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin // { inherit overlays; };
        modules = [
          ./modules/home.nix
          ./modules/fonts.nix
          ./modules/fzf.nix
          ./modules/gh.nix
          ./modules/git.nix
          ./modules/kitty.nix
          ./modules/packages.nix
          ./modules/pass.nix
          ./modules/scim.nix
          ./modules/shell.nix
          ./modules/spotify.nix
          ./modules/tmux.nix
          ./modules/vim.nix
        ];

      };
    };
    home = self.homeConfigurations.home.activationPackage;
    linux = self.homeConfigurations.linux.activationPackage;
  };
}
