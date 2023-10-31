{pkgs, ...}: {
  config.programs.helix = {
    enable = true;
    package = pkgs.helix;
    settings = {
      editor = {
        gutters = ["diff" "line-numbers" "spacer" "diagnostics"];
        cursorline = true;
        cursor-shape.insert = "bar";
        color-modes = true;
        true-color = true;
        lsp.display-messages = true;
        lsp.display-inlay-hints = false;
        file-picker = {
          max-depth = 4;
        };
        statusline = {
          mode = {
            normal = "NORMAL";
            select = "SELECT";
            insert = "INSERT";
          };
          left = ["mode" "file-name"];
          center = [];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" "version-control" "spacer"];
        };
      };
      theme = "github_dark";
      keys = {
        insert.esc = ["collapse_selection" "normal_mode"];
        select.esc = ["collapse_selection" "normal_mode"];
        normal.esc = ["collapse_selection" "normal_mode"];

        normal = {
          C-n = "goto_file_start";
          X = "extend_line_above";
          G = "goto_file_end";
          g.q = ":reflow";
          a = ["append_mode" "collapse_selection"];
          i = ["insert_mode" "collapse_selection"];
          ret = ["move_line_down" "goto_line_start"];
          space = {
            w = ":update";
            q = ":quit";
            G = ":sh gh browse";
          };
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter = {command = "alejandra";};
      }
      {
        name = "go";
        formatter = {command = "goimports";};
        language-servers = [
          "gopls"
          "golangci-lint-lsp"
        ];
      }
      {
        name = "lua";
        auto-format = true;
      }
      {
        name = "html";
        indent = {
          tab-width = 2;
          unit = " ";
        };
        auto-format = false;
        formatter = {
          command = "prettier";
          args = ["--parser" "html" "--tab-width" "2"];
        };
      }
      {
        name = "css";
        indent = {
          tab-width = 4;
          unit = " ";
        };
        formatter = {
          command = "prettier";
          args = ["--parser" "css" "--tab-width" "2"];
        };
      }
      {
        name = "typescript";
        indent = {
          tab-width = 4;
          unit = " ";
        };
        auto-format = true;
        formatter = {
          command = "prettier";
          args = ["--parser" "typescript" "--tab-width" "4"];
        };
      }
      {
        name = "svg";
        scope = "";
        roots = [];
        file-types = ["svg"];
        formatter = {
          command = "svgo";
          args = ["--pretty" "-"];
        };
      }
    ];
  };
}
