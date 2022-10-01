{
  config,
  pkgs,
  lib,
  ...
}: {
  config.programs.helix = {
    enable = true;
    
    settings = {
      theme = "base16_transparent";
      keys.normal = {
        space.w = ":write";
        space.q = ":quit";
      };
    };
  };
}
