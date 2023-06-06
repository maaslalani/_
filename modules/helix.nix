{pkgs, ...}: {
  config.programs.helix = {
    enable = true;
    package = pkgs.helix;
    settings = {
      editor = {
        gutters = ["diff" "line-numbers" "spacer" "diagnostics"];
        cursorline = true;
        cursor-shape.insert = "bar";
        true-color = true;
        lsp.display-messages = true;
        lsp.display-inlay-hints = false;
      };
      theme = "github_dark";
      keys.insert.esc = ["collapse_selection" "normal_mode"];
      keys.normal.esc = ["collapse_selection" "normal_mode"];
      keys.select.esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
      keys.normal = {
        X = "extend_line_above";
        a = ["append_mode" "collapse_selection"];
        g.q = ":reflow";
        i = ["insert_mode" "collapse_selection"];
        ret = ["move_line_down" "goto_line_start"];
        space = {
          w = ":write";
          q = ":quit";
        };
      };
    };
    languages = {
      rust.auto-format = true;
      nix.auto-format = true;
      go.auto-format = true;
      go.indent = {
        tab-width = 4;
        unit = "  ";
      };
      go.formatter = {command = "goimports";};
      html.auto-format = false;
    };
  };
}
