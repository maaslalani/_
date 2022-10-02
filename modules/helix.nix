{ config
, pkgs
, lib
, ...
}: {
  config.programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape.insert = "bar";
      theme = "base16_transparent";
      keys.normal = {
        space = {
          w = ":write";
          q = ":quit";
        };
      };
    };
    languages = [
      { name = "rust"; auto-format = true; }
      { name = "go"; auto-format = true; }
    ];
  };
}
