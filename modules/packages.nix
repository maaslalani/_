{
  pkgs,
  lib,
  ...
}: {
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
    agent-browser
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
    hunk
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

    # coding agents
    antigravity-cli
    claude-code
    # codex
    crush
    grok-build
    ollama
    opencode

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
    prettier
    svgo
    taplo
    tsx
    typescript-language-server
    uwu-colors
    vscode-langservers-extracted
    yaml-language-server
    zls
  ];
}
