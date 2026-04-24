{pkgs, ...}: {
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
          max-depth = 8;
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
      keys = let
        esc = ["collapse_selection" "normal_mode"];
      in {
        normal = {
          inherit esc;
          X = "extend_line_above";
          V = ["extend_line_below" "select_mode"];
          G = "goto_file_end";
          g.q = ":reflow";
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
          space.g.c = ":pipe-to gh browse -n %{buffer_name}:%{selection_line_start}-%{selection_line_end}";
          space.g.o = ":pipe-to gh browse %{buffer_name}:%{selection_line_start}-%{selection_line_end}";
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
      cook-lsp = {
        command = "cook";
        args = ["lsp"];
      };
      tinymist = {
        command = "tinymist";
        config.exportPdf = "onSave";
        config.outputPath = "$root/$dir/build/$name";
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
      }
      {
        name = "markdown";
        language-servers = ["marksman" "ltex-ls"];
      }
      {
        name = "go";
        formatter = {command = "goimports";};
        language-servers = ["gopls" "golangci-lint-lsp"];
        auto-format = true;
      }
      {
        name = "rust";
        language-servers = ["rust-analyzer"];
      }
      {
        name = "zig";
        language-servers = ["zls"];
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
        language-servers = ["css-languageserver"];
      }
      {
        name = "typescript";
        indent.tab-width = 4;
        indent.unit = " ";
        auto-format = false;
        formatter.command = "prettier";
        formatter.args = ["--parser" "typescript" "--tab-width" "4"];
        language-servers = ["typescript-language-server"];
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
        language-servers = ["fennel-language-server"];
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
        language-servers = ["tinymist"];
        scope = "source.typst";
        file-types = ["typ"];
        roots = [".git"];
        comment-token = "//";
      }
    ];
  };

  home.file.".config/helix/runtime/queries/cooklang/highlights.scm".source = builtins.toFile "highlights.scm" ''
    ; Cooklang syntax highlighting queries

    ; Comments — rendered at fg.muted, visually distinct from the brighter step text
    (comment) @comment
    (block_comment) @comment

    ; Inline notes are also annotative — treat like comments
    (note) @comment

    ; Step text — use @variable (fg.default) so it appears brighter than muted comments
    (text) @variable

    ; Sections
    (section_name) @markup.heading

    ; Metadata
    (metadata key: (metadata_key) @keyword)
    (metadata value: (metadata_value) @string)

    ; Frontmatter
    (frontmatter) @punctuation.delimiter
    (frontmatter_content) @string

    ; Ingredients
    "@" @punctuation.special
    (ingredient name: (ingredient_name) @function)

    ; Cookware
    "#" @punctuation.special
    (cookware name: (cookware_name) @constant)

    ; Timer
    "~" @punctuation.special
    (timer name: (timer_name) @constant)

    ; Amounts
    (quantity) @number

    ; Brackets
    "{" @punctuation.bracket
    "}" @punctuation.bracket
    "(" @punctuation.bracket
    ")" @punctuation.bracket

    ; Delimiters
    "---" @punctuation.delimiter
  '';
}
