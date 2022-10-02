{ config
, pkgs
, lib
, ...
}: {
  config.programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape.insert = "bar";
      theme = "base16";
      keys.normal = {
        space = {
          w = ":write";
          q = ":quit";
        };
      };
    };
    themes = {
      base16 =
        let
          transparent = "none";
          black = "#282A2E";
          brightblack = "#373B41";
          red = "#A54242";
          brightred = "#CC6666";
          green = "#8C9440";
          brightgreen = "#B5BD68";
          orange = "#DE935F";
          yellow = "#F0C674";
          blue = "#5F819D";
          brightblue = "#81A2BE";
          magenta = "#85678F";
          brightmagenta = "#B294BB";
          cyan = "#5E8D87";
          brightcyan = "#8ABEB7";
          gray = "#707880";
          white = "#C5C8C6";
        in
        {
          "ui.menu" = { bg = black;};
          "ui.menu.selected" = { bg = brightblack; };
          "ui.menu.scroll" = { bg = transparent; };
          "ui.window" = gray;
          "ui.linenr" = { fg = brightblack; };
          "ui.linenr.selected" = { fg = gray; };
          "ui.popup" = { fg = white; bg = black; };
          "ui.popup.info" = { fg = white; bg = transparent; };
          "ui.selection" = { fg = black; bg = blue; };
          "ui.selection.primary" = { modifiers = [ "reversed" ]; };
          "comment" = { fg = gray; };
          "ui.statusline" = { fg = gray; bg = transparent; };
          "ui.statusline.inactive" = { fg = brightblack; bg = transparent; };
          "ui.help" = { fg = gray; bg = transparent; };
          "ui.cursor" = { modifiers = [ "reversed" ]; };
          "variable" = white;
          "variable.builtin" = orange;
          "constant.numeric" = orange;
          "constant" = orange;
          "attributes" = blue;
          "type" = brightcyan;
          "ui.cursor.match" = { fg = yellow; modifiers = [ "underlined" ]; };
          "string" = brightgreen;
          "variable.other.member" = brightblue;
          "constant.character.escape" = yellow;
          "function" = white;
          "function.builtin" = magenta;
          "function.method" = blue;
          "constructor" = brightblue;
          "special" = orange;
          "keyword" = brightblue;
          "keyword.control.repeat" = magenta;
          "label" = magenta;
          "namespace" = blue;
          "diff.plus" = green;
          "diff.delta" = yellow;
          "diff.minus" = red;
          "diagnostic" = { modifiers = [ "underlined" ]; };
          "ui.gutter" = { bg = transparent; };
          "info" = blue;
          "hint" = gray;
          "debug" = gray;
          "warning" = yellow;
          "error" = red;
        };
    };
    languages = [
      { name = "rust"; auto-format = true; }
      { name = "go"; auto-format = true; }
    ];
  };
}
