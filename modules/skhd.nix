{config, ...}: let
  skhdPath = "${config.xdg.configHome}/skhd";
in {
  home.file."${skhdPath}/skhdrc".text = ''
    meh - b : open -a Safari
    meh - c : open -a Calendar
    meh - d : open -a Discord
    meh - f : open -a Finder
    meh - n : open -a Obsidian
    meh - r : open -a Reminders
    meh - t : open -a Ghostty

    meh - p : open /System/Library/PreferencePanes/Passwords.prefPane
  '';
}
