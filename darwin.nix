{ config, pkgs, ... }:

{
  users.users.maas = {
    description = "Maas Lalani";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    ctags
    fd
    fzf
    htop
    ripgrep
    screen
    tree
    zsh
  ];

  environment.darwinConfig = "/Users/maas/.nixpkgs/darwin-configuration.nix";
  environment.shells = [ pkgs.zsh ];
  programs.zsh.enable = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = false;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  system.stateVersion = 4;

  services.nix-daemon.enable = false;

  nix.useDaemon = false;
  nix.maxJobs = 4;
  nix.buildCores = 4;
}
