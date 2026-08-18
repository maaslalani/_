{config, ...}: let
  colorPreview = {
    name = "uwu-colors";
    only-features = ["document-colors"];
  };
  mkPrettier = parser: tabWidth: {
    command = "prettier";
    args = ["--parser" parser "--tab-width" (toString tabWidth)];
  };
in {
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
        file-picker = {
          max-depth = 8;
        };
        statusline = {
          mode = {
            normal = "NORMAL";
            select = "SELECT";
            insert = "INSERT";
          };
          left = ["mode" "file-name"];
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
      keys = let
        esc = ["collapse_selection" "normal_mode"];
      in {
        normal = {
          inherit esc;
          X = "extend_line_above";
          V = ["extend_line_below" "select_mode"];
          G = "goto_file_end";
          g.q = ":reflow";
          C-b = ":sh git blame -L %{cursor_line},%{cursor_line} -- %{buffer_name} | sed 's/).*$/)/'";
          C-r = ":reload";
          space = {
            w = ":write";
            q = ":quit";
            l.f = ":format";
            l.r = ":lsp-restart";
            l.g = ":sh gh browse";
            o = ":sh open build/$(sed 's/\\.typ$/.pdf/' <<< %{buffer_name})";
          };
        };
        insert = {
          inherit esc;
          C-n = "completion";
        };
        select = {
          inherit esc;
          A-s = ":pipe sort";
          space.g.c = ":sh gh browse -n %{buffer_name}:%{selection_line_start}-%{selection_line_end} | pbcopy";
          space.g.o = ":sh gh browse %{buffer_name}:%{selection_line_start}-%{selection_line_end}";
        };
      };
    };

    languages.language-server = {
      vhs-language-server = {
        command = "vhs";
        args = ["lsp"];
      };
      cook-lsp = {
        command = "cook";
        args = ["lsp"];
      };
      uwu-colors = {
        command = "uwu_colors";
      };
      tinymist.config = {
        exportPdf = "onSave";
        fontPaths = ["${config.home.path}/share/fonts"];
        outputPath = "$root/$dir/build/$name";
        systemFonts = false;
      };
    };

    languages.grammar = [
      {
        name = "fennel";
        source.git = "https://github.com/TravonteD/tree-sitter-fennel";
        source.rev = "517195970428aacca60891b050aa53eabf4ba78d";
      }
      {
        name = "cooklang";
        source.git = "https://github.com/cooklang/tree-sitter-cooklang";
        source.rev = "dcc971c1d70cbcbf45bc54111d02a4294c91d9a2";
      }
    ];

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter = {command = "alejandra";};
        language-servers = ["nil" "nixd" colorPreview];
      }
      {
        name = "markdown";
        language-servers = ["marksman"];
      }
      {
        name = "go";
        formatter = {command = "goimports";};
      }
      {
        name = "lua";
        auto-format = true;
      }
      {
        name = "vhs";
        auto-format = true;
        language-servers = ["vhs-language-server"];
      }
      {
        name = "html";
        auto-format = false;
        formatter = mkPrettier "html" 2;
      }
      {
        name = "css";
        formatter = mkPrettier "css" 2;
      }
      {
        name = "typescript";
        indent.tab-width = 4;
        indent.unit = "    ";
        formatter = mkPrettier "typescript" 4;
      }
      {
        name = "fennel";
        auto-format = true;
        comment-token = ";;";
        file-types = ["fnl"];
        injection-regex = "(fennel|fnl)";
        roots = [".git"];
        scope = "source.fnl";
      }
      {
        name = "cooklang";
        auto-format = true;
        comment-token = "--";
        file-types = ["cook"];
        grammar = "cooklang";
        injection-regex = "(cooklang|cook)";
        language-servers = ["cook-lsp"];
        roots = [];
        scope = "source.cook";
      }
      {
        name = "svg";
        scope = "";
        roots = [];
        file-types = ["svg"];
        formatter.command = "svgo";
        formatter.args = ["--pretty" "-"];
      }
      {
        name = "devicetree";
        file-types = ["dts" "dtsi" "keymap"];
      }
      {
        name = "toml";
        file-types = ["toml" "conf"];
      }
      {
        name = "typst";
        file-types = ["typ"];
        roots = [".git"];
      }
    ];
  };
}
