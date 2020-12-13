{ pkgs, ... }:
{
  nvim-telescope = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-telescope";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "6e6fbbc49eee19baeeea85c99aa8fb816fbd25e6";
      sha256 = "0X+OkkVDeGd8NR//jCxD1CCqAXFR+/usgUA24x7zPC0=";
    };
    dependencies = [];
  };

  popup-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "popup-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "popup.nvim";
      rev = "6f8f4cf35278956de1095b0d10701c6b579a2a57";
      sha256 = "n0htGwrYWro5SUP+A45J2O+mwLyXAWULvZMoFoOubFc=";
    };
    dependencies = [];
  };

  plenary-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "plenary-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "16eb57376ce62fbb86ebbd721fb7d2c1b1a0164f";
      sha256 = "9YZro3QXh216P4BafWQ9JSEfUL+ibi2CbdR1EGlcwVo=";
    };
    dependencies = [];
  };
}
