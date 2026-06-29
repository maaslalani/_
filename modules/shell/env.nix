{config, ...}: {
  programs.zsh.sessionVariables = rec {
    CARGO_BIN = "$HOME/.cargo/bin";
    CARGO_INCREMENTAL = "0";
    CARGO_TARGET_DIR = "${config.xdg.cacheHome}/cargo";
    COLORTERM = "truecolor";
    EDITOR = "hx";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    GOBIN = "${GOPATH}/bin";
    GOPATH = "${config.xdg.configHome}/go";
    KEYTIMEOUT = "1";
    LOCAL_BIN = "$HOME/.local/bin";
    NIX_BIN = "$HOME/.nix-profile/bin";
    NIX_PATH = builtins.concatStringsSep ":" ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
    NODE_NO_WARNINGS = "1";
    NOTES = "$HOME/Documents/notes";
    OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
    PATH = builtins.concatStringsSep ":" [GOBIN NIX_BIN LOCAL_BIN CARGO_BIN "$PATH"];
    RUSTC_WRAPPER = "sccache";
    SHELL = "${config.programs.zsh.package}/bin/zsh";
    SHELL_SESSIONS_DISABLE = "1";
    SRC = "$HOME/src";
    TYPST_FONT_PATHS = "$HOME/.nix-profile/share/fonts";
    XDG_CACHE_HOME = config.xdg.cacheHome;
    XDG_CONFIG_HOME = config.xdg.configHome;
    XDG_DATA_HOME = config.xdg.dataHome;
  };
}
