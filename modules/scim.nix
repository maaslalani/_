{
  config,
  pkgs,
  libs,
  ...
}: let
  scimPath = "${config.xdg.configHome}/sc-im";
in {
  home.file."${scimPath}/scimrc".text = ''
    color "type=HEADINGS bold=0 fg=BLUE bg=DEFAULT_COLOR"
    color "type=HEADINGS_ODD bold=0 fg=BLUE bg=DEFAULT_COLOR"
    color "type=CELL_SELECTION bold=0 fg=CYAN bg=DEFAULT_COLOR"
    color "type=CELL_SELECTION_SC bold=0 fg=BLACK bg=WHITE"
    color "type=NUMB bold=0 fg=MAGENTA bg=DEFAULT_COLOR"
    color "type=CELL_NEGATIVE bold=0 fg=RED bg=DEFAULT_COLOR"
    color "type=STRG bold=0 fg=GREEN bg=DEFAULT_COLOR"
    color "type=EXPRESSION bold=0 fg=CYAN bg=DEFAULT_COLOR"
    color "type=CELL_ID bold=0 fg=CYAN bg=DEFAULT_COLOR"
    color "type=CELL_FORMAT bold=0 fg=WHITE bg=DEFAULT_COLOR"
    color "type=CELL_CONTENT bold=0 fg=CYAN bg=DEFAULT_COLOR"

    nmap "a" "="
    nmap "A" "\"
  '';
}
