{pkgs, ...}: {
  home.packages = with pkgs; [
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
  ];
}
