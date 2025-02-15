{
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  isGraphical = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/mnt/extra/transmission/download";
      incomplete-dir = "/mnt/extra/transmission/.incomplete";
    };
  };
  /*
    services.lanraragi.enable = true;
    services.lanraragi.port = 3001;
    services.lanraragi.passwordFile = pkgs.writeText "pass" "password";
    services.lanraragi.package = pkgs.lanraragi.overrideAttrs (
      prev:
      {
      }
    );
  */

  services.speechd.enable = true;

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  boot.kernelParams = [
    "libata.noacpi=1" # Fixes some BIOS error
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest; # sway fix???
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:1:0";
    };
    modesetting.enable = true; # its true by default, but set it anyway
    forceFullCompositionPipeline = true;
  };

  environment.etc."X11/xorg.conf.d/10-disable-nvidia-phantom-monitor.conf" =
    lib.mkIf (!config.withWayland)
      {
        text = ''
          Section "Monitor"
              Identifier "None-1-1"
              Option "Ignore" "true"
          EndSection
        '';
      };

  networking.firewall = {
    allowedUDPPorts = [
      7777
      25565
      45000
      45001
    ];
    allowedTCPPorts = [
      7777
      25565
      45000
      45001
    ];
  };

  services.tailscale.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [
        ""
        "${pkgs.networkmanager}/bin/nm-online -q"
      ];
    };
  };

  home-manager.users.toma = {
    modules = {
      picom.vSync = false; # Turns off the default screen-tearing fix
      i3-sway.show-battery = false;
      notification.battery = false;
      fcitx5.enable = false;
    };
    home = {
      sessionVariables = {
        # https://bugs.webkit.org/show_bug.cgi?id=228268
        # fix for nvidia proprietary drivers
        "WEBKIT_DISABLE_COMPOSITING_MODE" = "1";
      };
      packages = with pkgs; [ ];
    };
  };
}
