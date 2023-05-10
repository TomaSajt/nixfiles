{ pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/mnt/extra/transmission/download";
      incomplete-dir = "/mnt/extra/transmission/.incomplete";
    };
  };


  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:1:0";
    };
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  home-manager.users.toma = {
    # Turn off the default screen-tearing fix
    services.picom.vSync = lib.mkForce false;
    home.packages = with pkgs; [
      heroic
      steam
    ];

  };
}
