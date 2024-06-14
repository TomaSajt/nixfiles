{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  isDesktop = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # Fixes some BIOS error
  boot.kernelParams = [ "libata.noacpi=1" ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/mnt/extra/transmission/download";
      incomplete-dir = "/mnt/extra/transmission/.incomplete";
    };
  };

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  hardware.opengl.driSupport32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:1:0";
    };
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
  };

  environment.etc."X11/xorg.conf.d/10-disable-nvidia-phantom-monitor.conf".text = ''
    Section "Monitor"
        Identifier "None-1-1"
        Option "Ignore" "true"
    EndSection
  '';

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

  home-manager.users.toma = {
    modules = {
      picom.vSync = false; # Turns off the default screen-tearing fix
      i3.show-battery = false;
      notification.battery = false;
      fcitx5.enable = true;
    };
    home = {
      sessionVariables = {
        # https://bugs.webkit.org/show_bug.cgi?id=228268
        # fix for nvidia proprietary drivers
        "WEBKIT_DISABLE_COMPOSITING_MODE" = "1";
      };
      packages = with pkgs; [ ];
    };

    services.syncthing.enable = true;
  };
}
