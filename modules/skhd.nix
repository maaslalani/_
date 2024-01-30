{config, ...}: let
  skhdPath = "${config.xdg.configHome}/skhd";
in {
  home.file."${skhdPath}/skhdrc".text = ''
    meh - b : open -a "Safari"
    meh - c : open -a "Notion Calendar"
    meh - d : open -a "Discord"
    meh - f : open -a "Finder"
    meh - n : open -a "Obsidian"
    meh - r : open -a "Reminders"
    meh - t : open -a "Ghostty"

    meh - p : open /System/Library/PreferencePanes/Passwords.prefPane

    ctrl - t : skhd --key escape

    alt - l : yabai -m window --focus east || yabai -m display --focus next
    alt - h : yabai -m window --focus west || yabai -m display --focus prev
    shift + alt - l : yabai -m window --grid 1:2:1:1:1:1
    shift + alt - h : yabai -m window --grid 1:2:0:1:1:1

    meh - l : yabai -m window --display next; yabai -m display --focus next
    meh - h : yabai -m window --display prev; yabai -m display --focus prev
  '';
}
