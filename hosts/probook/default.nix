{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  isGraphical = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-e04bca55-7792-47f1-afe8-5b0b9205aca0".device =
    "/dev/disk/by-uuid/e04bca55-7792-47f1-afe8-5b0b9205aca0";

  home-manager.users.toma = {
    modules.alacritty.font-size = if config.withWayland then 12 else 8;
    modules.fcitx5.enable = true;
    home.packages = [ ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.transmission = {
    enable = true;
    downloadDirPermissions = "775";
    settings = {
      download-dir = "/transmission/download";
      incomplete-dir = "/transmission/.incomplete";
    };
  };

  # Enable touchpad support (with natural scrolling)
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

}
