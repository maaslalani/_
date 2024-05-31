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
            C-n = "completion";
          };

          normal = {
            X = "extend_line_above";
            V = ["extend_line_below" "select_mode"];
            G = "goto_file_end";
            g.q = ":reflow";
            space = {
              w = ":write";
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
        vhs-language-server = {
          command = "vhs";
          args = ["lsp"];
        };
        helix-gpt = {
          command = "helix-gpt";
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
          language-servers = ["nil" "helix-gpt"];
        }
        {
          name = "bash";
          language-servers = ["bash-language-server" "helix-gpt"];
        }
        {
          name = "markdown";
          language-servers = ["marksman" "ltex-ls" "helix-gpt"];
        }
        {
          name = "go";
          formatter = {command = "goimports";};
          language-servers = ["gopls" "golangci-lint-lsp" "helix-gpt"];
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer" "helix-gpt"];
        }
        {
          name = "zig";
          language-servers = ["zls" "helix-gpt"];
        }
        {
          name = "lua";
          auto-format = true;
        }
        {
          name = "vhs";
          auto-format = true;
          file-types = ["tape"];
          language-servers = ["vhs-language-server"];
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
          language-servers = ["css-languageserver" "helix-gpt"];
        }
        {
          name = "typescript";
          indent.tab-width = 4;
          indent.unit = " ";
          auto-format = true;
          formatter.command = "prettier";
          formatter.args = ["--parser" "typescript" "--tab-width" "4"];
          language-servers = ["typescript-language-server" "helix-gpt"];
        }
        {
          name = "fennel";
          auto-format = true;
          comment-token = ";;";
          file-types = ["fnl"];
          formatter.args = ["-"];
          formatter.command = "fnlfmt";
          grammar = "fennel";
          indent.tab-width = 2;
          indent.unit = "  ";
          injection-regex = "(fennel|fnl)";
          language-servers = ["fennel-language-server" "helix-gpt"];
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
