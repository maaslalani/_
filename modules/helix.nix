{
  pkgs,
  config,
  ...
}: let
  highlightPath = "${config.xdg.configHome}/helix/runtime/queries/fennel/highlights.scm";
in {
  config = {
    home.file.${highlightPath}.source = "${pkgs.fnl}/highlights.scm";
    programs.helix = {
      enable = true;
      package = pkgs.helix;
      settings = {
        editor = {
          gutters = [
            "diff"
            "line-numbers"
            "spacer"
            "diagnostics"
          ];
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
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-line-ending"
              "file-type"
              "version-control"
              "spacer"
            ];
          };
        };
        theme = "github_dark";
        keys = rec {
          normal.esc = ["collapse_selection" "normal_mode"];
          insert.esc = normal.esc;
          select.esc = normal.esc;

          insert = {
            C-e = "completion";
          };

          normal = {
            X = "extend_line_above";
            G = "goto_file_end";
            g.q = ":reflow";
            ret = ["move_line_down" "goto_first_nonwhitespace"];
            space = {
              w = ":update";
              q = ":quit";
              l.f = ":format";
              l.r = ":lsp-restart";
              l.g = ":sh gh browse";
            };
          };
        };
      };

      languages.language-server = {
        fennel-language-server = {
          command = "fennel-language-server";
          args = ["lsp" "stdio"];
        };
        copilot = {
          command = "copilot";
          args = ["--stdio"];
        };
      };

      languages.grammar = [
        {
          name = "fennel";
          source.git = "https://github.com/TravonteD/tree-sitter-fennel";
          source.rev = "517195970428aacca60891b050aa53eabf4ba78d";
        }
      ];

      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {command = "alejandra";};
        }
        {
          name = "go";
          formatter = {command = "goimports";};
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
        }
        {
          name = "lua";
          auto-format = true;
        }
        {
          name = "html";
          indent.tab-width = 2;
          indent.unit = " ";
          auto-format = false;
          formatter.command = "prettier";
          formatter.args = ["--parser" "html" "--tab-width" "2"];
        }
        {
          name = "css";
          indent.tab-width = 4;
          indent.unit = " ";
          formatter.command = "prettier";
          formatter.args = ["--parser" "css" "--tab-width" "2"];
        }
        {
          name = "typescript";
          indent.tab-width = 4;
          indent.unit = " ";
          auto-format = true;
          formatter.command = "prettier";
          formatter.args = ["--parser" "typescript" "--tab-width" "4"];
        }
        {
          auto-format = true;
          comment-token = ";;";
          file-types = ["fnl"];
          formatter.args = ["-"];
          formatter.command = "fnlfmt";
          grammar = "fennel";
          indent.tab-width = 2;
          indent.unit = "  ";
          injection-regex = "(fennel|fnl)";
          language-servers = ["fennel-language-server"];
          name = "fennel";
          roots = [".git"];
          scope = "source.fnl";
        }
        {
          name = "svg";
          scope = "";
          roots = [];
          file-types = ["svg"];
          formatter.command = "svgo";
          formatter.args = ["--pretty" "-"];
        }
      ];
    };
  };
}
