{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_GB.UTF-8";

  console.keyMap = "colemak";

  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.maas = {
    isNormalUser = true;
    description = "Maas Lalani";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  services.getty.autologinUser = "maas";
  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  system.stateVersion = "23.05";
}
