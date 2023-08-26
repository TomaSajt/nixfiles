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
    allowedUDPPorts = [ 7777 25565 ];
    allowedTCPPorts = [ 7777 25565 ];
  };

  #services.lanraragi.enable = true;

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
    home.packages = with pkgs; [
      # Kdenlive
      kdenlive
      #glaxnimate
      #mediainfo
    ];
  };
}
