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

    meh - h : yabai -m window --grid 8:8:0:0:4:8
    meh - j : yabai -m window --grid 8:8:0:4:8:4
    meh - k : yabai -m window --grid 8:8:0:0:8:4
    meh - l : yabai -m window --grid 8:8:4:0:4:8
    meh - o : yabai -m window --grid 8:8:0:0:8:8
  '';
}
