{pkgs, ...}: {
  home.packages = with pkgs; [
    dejavu_fonts
    fira-code
    hack-font
    ibm-plex
    inconsolata
    jetbrains-mono
    liberation_ttf
    noto-fonts
    roboto-mono
    source-code-pro
    ttf_bitstream_vera
    (
      nerdfonts.override {
        fonts = [
          "Hack"
          "FiraCode"
          "DejaVuSansMono"
          "SourceCodePro"
          "RobotoMono"
          "JetBrainsMono"
        ];
      }
    )
  ];
}
