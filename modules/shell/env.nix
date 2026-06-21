{config, ...}: let
  pathJoin = builtins.concatStringsSep ":";
  commaJoin = builtins.concatStringsSep ",";

  environment = rec {
    LOCAL_BIN = "$HOME/.local/bin";
    COLORTERM = "truecolor";
    EDITOR = "hx";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    GOBIN = "${GOPATH}/bin";
    GOPATH = "${config.xdg.configHome}/go";
    CARGO_BIN = "$HOME/.cargo/bin";
    KEYTIMEOUT = "1";
    NIX_BIN = "$HOME/.nix-profile/bin";
    NIX_PATH = pathJoin ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
    OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
    TYPST_FONT_PATHS = "$HOME/.nix-profile/share/fonts";
    SHELL = "zsh";
    SHELL_SESSIONS_DISABLE = "1";
    SRC = "$HOME/src";
    XDG_CACHE_HOME = config.xdg.cacheHome;
    XDG_CONFIG_HOME = config.xdg.configHome;
    NODE_NO_WARNINGS = "1";
    XDG_DATA_HOME = config.xdg.dataHome;
    NOTES = "$HOME/Documents/notes";

    SWITCH_PROJECTS = commaJoin [
      "$HOME/Developer/copilot.worktrees"
      "$HOME/.copilot/copilot-worktrees/copilot/"
    ];

    CARGO_INCREMENTAL = "0";
    CARGO_TARGET_DIR = "${config.xdg.cacheHome}/cargo";
    RUSTC_WRAPPER = "sccache";

    PATH = pathJoin [
      GOBIN
      NIX_BIN
      LOCAL_BIN
      CARGO_BIN
      "$PATH"
    ];
  };
in {
  programs.zsh.sessionVariables = environment;
}
