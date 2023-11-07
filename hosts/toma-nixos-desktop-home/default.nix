{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

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

  networking.firewall = {
    allowedUDPPorts = [ 7777 25565 3131 ];
    allowedTCPPorts = [ 7777 25565 3131 ];
  };

  services.lanraragi = {
    enable = true;
    port = 6969;
    passwordFile = pkgs.writeText "lrr-pass" "poggers123"; # ayo, wtf, who puts secrets in public repos??
    redis = {
      port = 6971;
      passwordFile = pkgs.writeText "lrr-pass" "epic-pass";
    };
  };

  services.redis.servers.lrr-test-5 = {
    enable = true;
    port = 9998;
    requirePass = "asd";
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

  home-manager.users.toma = {
    modules = {
      picom.vSync = false; # Turns off the default screen-tearing fix
      i3.show-battery = false;
      notification.battery = false;
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
