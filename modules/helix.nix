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
        gutters = ["diagnostics" "spacer" "diff" "spacer" "line-numbers" "spacer"];
        cursorline = true;
        cursor-shape.insert = "bar";
        file-picker.max-depth = 3;
        true-color = true;
        lsp.display-messages = true;
      };
      theme = "charm";
      keys.insert = {
        esc = ["collapse_selection" "normal_mode"];
      };
      keys.select = {
        esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
      };
      keys.normal = {
        esc = ["collapse_selection" "normal_mode"];
        g.q = ":reflow";
        X = "extend_line_above";
        ret = ["move_line_down" "goto_line_start"];
        G = "goto_file_end";
        i = ["insert_mode" "collapse_selection"];
        a = ["append_mode" "collapse_selection"];
        space.w = ":write";
        space.q = ":quit";
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
        language-server = {command = "nil";};
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
        name = "html";
        language-server = {command = "html-languageserver";};
      }
      {
        name = "css";
        language-server = {command = "css-languageserver";};
      }
      {
        name = "scss";
        language-server = {command = "css-languageserver";};
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
    ];
    themes = {
      charm = let
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
        "ui.cursor" = {
          modifiers = ["reversed"];
        };
        "ui.virtual.ruler" = {
          bg = "#1a1a1a";
        };
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
        "diagnostic" = {
          modifiers = ["underlined"];
        };
        "ui.gutter" = {
          bg = transparent;
        };
        "info" = normal.blue;
        "hint" = normal.white;
        "debug" = normal.white;
        "warning" = normal.yellow;
        "error" = normal.red;

        "markup.heading.marker" = "#00b2ff";
        "markup.heading.1" = "#00b2ff";
        "markup.heading.2" = "#00b2ff";
        "markup.heading.3" = "#00b2ff";
        "markup.heading.4" = "#00b2ff";
        "markup.heading.5" = "#00b2ff";
        "markup.heading.6" = "#00b2ff";
        "markup.bold" = {
          modifiers = ["bold"];
        };
        "markup.italic" = {
          modifiers = ["italic"];
        };
        "markup.underline.link" = {
          fg = "#008a88";
          modifiers = ["underlined"];
        };
        "markup.raw.inline" = {
          bg = "#303030";
          fg = "#ff4f58";
        };
        "markup.list.unnumbered" = bright.black;
        "markup.list.numbered" = bright.black;
        "markup.raw.block" = {
          fg = bright.black;
        };
        "markup.link.url" = {
          fg = "#008a88";
          modifiers = ["underlined"];
        };
        "markup.link.label" = {
          fg = "#00b255";
        };
        "markup.link.text" = {
          fg = "#00b255";
        };
      };
    };
  };
}
