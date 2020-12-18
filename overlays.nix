{
  overlay = self: super: {
    telescope-nvim = self.vimUtils.buildVimPluginFrom2Nix {
      name = "nvim-telescope";
      src = self.fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope.nvim";
        rev = "6e6fbbc49eee19baeeea85c99aa8fb816fbd25e6";
        sha256 = "0X+OkkVDeGd8NR//jCxD1CCqAXFR+/usgUA24x7zPC0=";
      };
      dependencies = [];
    };

    popup-nvim = self.vimUtils.buildVimPluginFrom2Nix {
      name = "popup-nvim";
      src = self.fetchFromGitHub {
        owner = "nvim-lua";
        repo = "popup.nvim";
        rev = "6f8f4cf35278956de1095b0d10701c6b579a2a57";
        sha256 = "n0htGwrYWro5SUP+A45J2O+mwLyXAWULvZMoFoOubFc=";
      };
      dependencies = [];
    };

    plenary-nvim = self.vimUtils.buildVimPluginFrom2Nix {
      name = "plenary-nvim";
      src = self.fetchFromGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "16eb57376ce62fbb86ebbd721fb7d2c1b1a0164f";
        sha256 = "9YZro3QXh216P4BafWQ9JSEfUL+ibi2CbdR1EGlcwVo=";
      };
      dependencies = [];
    };

    colorbuddy-nvim = self.vimUtils.buildVimPluginFrom2Nix {
      name = "colorbuddy-nvim";
      src = self.fetchFromGitHub {
        owner = "tjdevries";
        repo = "colorbuddy.nvim";
        rev = "ee11ea2e0305de55f3a8ba9e9996ed72bbdc99e5";
        sha256 = "cEzT9RhE+voYgwY53xjNH5j88Uk+L/DmIDsFMN5plm8=";
      };
      dependencies = [];
    };

    nvim-treesitter = self.vimUtils.buildVimPluginFrom2Nix {
      name = "nvim-treesitter";
      src = self.fetchFromGitHub {
        owner = "nvim-treesitter";
        repo = "nvim-treesitter";
        rev = "a5baf151bd78a88c88078b197657f277bcf06058";
        sha256 = "2Sf6+qO4T26IcHaMGSaKmYbvR6pWkgmLXsJFA/HH/W4=";
      };
      dependencies = [];
    };

    nordbuddy-nvim = self.vimUtils.buildVimPluginFrom2Nix {
      name = "nordbuddy";
      src = self.fetchFromGitHub {
        owner = "maaslalani";
        repo = "nordbuddy";
        rev = "005778c5902c1311f8c3d54f4182abfed87d6604";
        sha256 = "DLzxXDeEN7SAU1hvV3Y+FTC1malPi/U4rS1K5eyCGzI=";
      };
      dependencies = [];
    };
  };
}
