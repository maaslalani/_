{config, ...}: let
  skhdPath = "${config.xdg.configHome}/skhd";
in {
  home.file."${skhdPath}/skhdrc".text = ''
    ctrl + shift - b : open -a "Safari"
    ctrl + shift - c : open -a "Notion Calendar"
    ctrl + shift - d : open -a "Discord"
    ctrl + shift - f : open -a "Finder"
    ctrl + shift - n : open -a "Obsidian"
    ctrl + shift - r : open -a "Reminders"
    ctrl + shift - t : open -a "Ghostty"
    ctrl + shift - p : open /System/Library/PreferencePanes/Passwords.prefPane

    ctrl - space : skhd --key "cmd - space"
    ctrl - t : skhd --key escape

    alt - l : yabai -m window --focus east || yabai -m display --focus next
    alt - h : yabai -m window --focus west || yabai -m display --focus prev
    shift + alt - l : yabai -m window --grid 1:2:1:1:1:1
    shift + alt - h : yabai -m window --grid 1:2:0:1:1:1

    meh - l : yabai -m window --display next; yabai -m display --focus next
    meh - h : yabai -m window --display prev; yabai -m display --focus prev
  '';
}
