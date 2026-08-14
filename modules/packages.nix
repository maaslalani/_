{
  pkgs,
  lib,
  ...
}: {
  home.username = "maas";
  home.stateVersion = "25.05";
  home.homeDirectory = "/Users/maas";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  xdg.enable = true;

  home.packages = with pkgs; [
    # fonts
    dejavu_fonts
    fira-code
    hack-font
    ibm-plex
    inter
    inconsolata
    jetbrains-mono
    liberation_ttf
    newcomputermodern
    noto-fonts
    roboto-mono
    source-code-pro
    ttf_bitstream_vera

    # tools
    asciinema
    asciinema-agg
    bat
    btop
    bun
    cachix
    chafa
    charm-freeze
    comma
    cook-cli
    coreutils
    darwin.trash
    difftastic
    docker
    eza
    hunk
    fd
    fnlfmt
    gh-dash
    glow
    gnupg
    go
    google-cloud-sdk
    goreleaser
    graph-easy
    graphviz
    gum
    gws
    handy
    herdr
    httpie
    imagemagick
    jdk25
    jq
    melt
    mosh
    nodejs
    openssl
    pastel
    pnpm
    pop
    redis
    ripgrep
    rustup
    (lib.hiPrio rust-analyzer)
    sc-im
    sd
    serve
    skate
    tdf
    tinymist
    tmux
    tree-sitter
    ttyd
    typescript
    typioca
    typst
    uv
    vhs
    yq
    zed-editor
    zig
    zoxide

    # coding agents
    claude-code
    codex
    crush
    ollama
    opencode
    pi-coding-agent
    grok-build

    # terminals
    alacritty
    iterm2
    kitty
    warp-terminal

    # lsp
    alejandra
    bash-language-server
    dot-language-server
    eslint
    fennel-ls
    golangci-lint
    golangci-lint-langserver
    gopls
    gotools
    lua-language-server
    marksman
    nixpkgs-fmt
    prettier
    proselint
    revive
    svgo
    taplo
    tsx
    typescript-language-server
    uwu-colors
    vscode-langservers-extracted
    write-good
    yaml-language-server
    zls
  ];
}
