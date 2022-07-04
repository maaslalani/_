{ config, pkgs, lib, ... }:
let
  raycastPath = "${config.xdg.configHome}/raycast/scripts";
  header = title: mode: ''
    #!/bin/bash

    # @raycast.schemaVersion 1
    # @raycast.title ${title}
    # @raycast.mode ${mode}
  '';
  metadata = icon: packageName: ''
    # @raycast.icon ${icon}
    # @raycast.packageName ${packageName}
  '';
in
{
  home.file."${raycastPath}/kitty.sh" = {
    text = ''
      ${header "Kitty" "silent"}
      ${metadata "🐱" "Launch"}

      open $HOME/.nix-profile/Applications/kitty.app
    '';
    executable = true;
  };

  home.file."${raycastPath}/pass.sh" = {
    text = ''
      ${header "Pass" "silent"}
      ${metadata "🔑" "Passwords"}
      # @raycast.argument1 { "type": "text", "placeholder": "Password" }

      export GNUPGHOME=$HOME/.local/share/gnupg
      export PASSWORD_STORE_DIR=$HOME/.local/share/pass
      export PATH=$HOME/.nix-profile/bin:/usr/bin

      pass "$1" | pbcopy
    '';
    executable = true;
  };
}
