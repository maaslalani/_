{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    wireless = {
      userControlled.enable = true;
      networks = {
        # wpa_cli
        # > add_network
        # > set_network 0 ssid <SSID>
        # > set_network 0 key_mgmt WPA-PSK
        # > set_network 0 psk <PSK>
        # > enable_network 0
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_GB.UTF-8";

  console.keyMap = "colemak";

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  hardware = {
    enableAllFirmware = true;
    opengl.enable = true;
    nvidia.modesetting.enable = true;
    firmware = [ pkgs.sof-firmware ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = false;
  };

  users.users.maas = {
    isNormalUser = true;
    description = "Maas Lalani";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  services.getty.autologinUser = "maas";

  nix.gc.automatic = true;

  system.stateVersion = "23.05";
}
