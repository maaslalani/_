_: {
  home.username = "maas";
  home.stateVersion = "25.05";
  home.homeDirectory = "/Users/maas";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  xdg.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
