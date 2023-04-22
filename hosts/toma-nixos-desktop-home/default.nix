{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

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
    home.packages = with pkgs; [
      heroic
      steam
    ];
  };
}
