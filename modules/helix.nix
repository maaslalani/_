{
  config,
  pkgs,
  lib,
  ...
}: {
  config.programs.helix = {
    enable = true;
    package = pkgs.helix;
    settings = {
      editor = {
        cursor-shape.insert = "bar";
        file-picker.max-depth = 5;
      };
      theme = "base16";
      keys.normal = {
        g.q = ":reflow";
        X = "extend_line_above";
        space = {
          w = ":write";
          q = ":quit";
        };
      };
    };
    languages = [
      {
        name = "rust";
        auto-format = true;
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {command = "alejandra";};
      }
      {
        name = "go";
        indent = {
          tab-width = 4;
          unit = "  ";
        };
        auto-format = true;
        formatter = {command = "goimports";};
      }
      {
        name = "fennel";
        file-types = ["fnl"];
        formatter = {command = "fnlfmt";};
        scope = "source.scheme";
        injection-regex = "scheme";
        comment-token = ";";
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        grammar = "scheme";
        roots = [];
      }
      {
        name = "json";
        file-types = ["lock" "json"];
        language-server = {command = "vscode-json-languageserver";};
      }
      {
        name = "html";
        language-server = {command = "html-languageserver";};
      }
      {
        name = "css";
        language-server = {command = "css-languageserver";};
      }
      {
        name = "javascript";
        auto-format = true;
      }
    ];
    themes = {
      base16 = let
        transparent = "none";
        normal = {
          black = "#282A2E";
          red = "#A54242";
          green = "#8C9440";
          yellow = "#DE935F";
          blue = "#5F819D";
          magenta = "#85678F";
          cyan = "#5E8D87";
          white = "#707880";
        };
        bright = {
          black = "#373B41";
          red = "#CC6666";
          green = "#B5BD68";
          yellow = "#F0C674";
          blue = "#81A2BE";
          magenta = "#B294BB";
          cyan = "#8ABEB7";
          white = "#C5C8C6";
        };
      in {
        "ui.menu" = {bg = normal.black;};
        "ui.menu.selected" = {bg = bright.black;};
        "ui.menu.scroll" = {
          fg = normal.black;
          bg = normal.black;
        };
        "ui.window" = normal.black;
        "ui.linenr" = {fg = bright.black;};
        "ui.linenr.selected" = {fg = normal.white;};
        "ui.popup" = {
          fg = bright.white;
          bg = normal.black;
        };
        "ui.popup.info" = {
          fg = bright.white;
          bg = transparent;
        };
        "ui.selection" = {
          fg = normal.black;
          bg = normal.blue;
        };
        "ui.selection.primary" = {modifiers = ["reversed"];};
        "comment" = {fg = normal.white;};
        "ui.statusline" = {
          fg = normal.white;
          bg = transparent;
        };
        "ui.statusline.inactive" = {
          fg = bright.black;
          bg = transparent;
        };
        "ui.help" = {
          fg = normal.white;
          bg = transparent;
        };
        "ui.cursor" = {modifiers = ["reversed"];};
        "variable" = bright.white;
        "variable.builtin" = normal.yellow;
        "constant.numeric" = normal.yellow;
        "constant" = normal.yellow;
        "attributes" = normal.blue;
        "type" = bright.cyan;
        "ui.cursor.match" = {
          fg = bright.yellow;
          modifiers = ["underlined"];
        };
        "string" = bright.green;
        "variable.other.member" = bright.blue;
        "constant.character.escape" = bright.yellow;
        "function" = normal.yellow;
        "function.builtin" = normal.magenta;
        "function.method" = normal.blue;
        "constructor" = bright.blue;
        "special" = normal.yellow;
        "keyword" = bright.blue;
        "keyword.control.repeat" = normal.magenta;
        "label" = normal.magenta;
        "namespace" = normal.blue;
        "diff.plus" = normal.green;
        "diff.delta" = bright.yellow;
        "diff.minus" = normal.red;
        "diagnostic" = {modifiers = ["underlined"];};
        "ui.gutter" = {bg = transparent;};
        "info" = normal.blue;
        "hint" = normal.white;
        "debug" = normal.white;
        "warning" = bright.yellow;
        "error" = normal.red;
      };
    };
  };
}
