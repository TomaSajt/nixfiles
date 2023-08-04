{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelParams = [
    "libata.noacpi=1" # Fixes some BIOS error
  ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/mnt/extra/transmission/download";
      incomplete-dir = "/mnt/extra/transmission/.incomplete";
    };
  };

  networking.firewall = {
    allowedUDPPortRanges = [{ from = 25565; to = 25575; } { from = 7777; to = 7777; }];
    allowedTCPPortRanges = [{ from = 25565; to = 25575; } { from = 7777; to = 7777; }];
  };


  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

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
    modules.picom.vSync = false; # Turns off the default screen-tearing fix
    home.packages = with pkgs; [
      # Kdenlive
      kdenlive
      #glaxnimate
      #mediainfo
    ];
  };
}
