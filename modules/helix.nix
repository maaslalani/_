{
  config,
  pkgs,
  lib,
  ...
}: let
  colors = import ./colors.nix;
in {
  config.programs.helix = {
    enable = true;
    package = pkgs.helix;
    settings = {
      editor = {
        cursor-shape.insert = "bar";
        file-picker.max-depth = 3;
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
        normal = colors.normal;
        bright = colors.bright;
      in {
        "ui.menu" = {bg = normal.black;};
        "ui.menu.selected" = {bg = bright.black;};
        "ui.menu.scroll" = {
          fg = normal.black;
          bg = normal.black;
        };
        "ui.window" = normal.black;
        "ui.linenr" = {fg = normal.black;};
        "ui.linenr.selected" = {fg = normal.white;};
        "ui.popup" = {
          fg = normal.white;
          bg = normal.black;
        };
        "ui.popup.info" = {
          fg = normal.white;
          bg = transparent;
        };
        "ui.selection" = {
          fg = normal.black;
          bg = normal.blue;
        };
        "ui.selection.primary" = {modifiers = ["reversed"];};
        "comment" = {fg = bright.black;};
        "ui.statusline" = {
          fg = normal.white;
          bg = transparent;
        };
        "ui.statusline.inactive" = {
          fg = normal.black;
          bg = transparent;
        };
        "ui.help" = {
          fg = normal.white;
          bg = transparent;
        };
        "ui.cursor" = {modifiers = ["reversed"];};
        "variable" = normal.white;
        "variable.builtin" = normal.yellow;
        "constant.numeric" = normal.yellow;
        "constant" = normal.yellow;
        "attributes" = normal.blue;
        "type" = normal.cyan;
        "ui.cursor.match" = {
          fg = normal.cyan;
          modifiers = ["underlined"];
        };
        "string" = normal.green;
        "variable.other.member" = normal.blue;
        "constant.character.escape" = normal.yellow;
        "function" = normal.yellow;
        "function.builtin" = normal.blue;
        "function.method" = normal.blue;
        "constructor" = normal.blue;
        "special" = normal.yellow;
        "keyword" = bright.magenta;
        "keyword.control.repeat" = normal.magenta;
        "label" = normal.magenta;
        "namespace" = normal.blue;
        "diff.plus" = normal.green;
        "diff.delta" = normal.yellow;
        "diff.minus" = normal.red;
        "diagnostic" = {modifiers = ["underlined"];};
        "ui.gutter" = {bg = transparent;};
        "info" = normal.blue;
        "hint" = normal.white;
        "debug" = normal.white;
        "warning" = normal.yellow;
        "error" = normal.red;
      };
    };
  };
}
