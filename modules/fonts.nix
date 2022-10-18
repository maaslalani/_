{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    dejavu_fonts
    hack-font
    ibm-plex
    inconsolata
    jetbrains-mono
    liberation_ttf
    noto-fonts
    roboto-mono
    source-code-pro
    ttf_bitstream_vera
    hack-font
    fira-code
    (
      nerdfonts.override {
        fonts = [
          "Hack"
          "FiraCode"
          "DejaVuSansMono"
          "SourceCodePro"
          "RobotoMono"
        ];
      }
    )
  ];
}
