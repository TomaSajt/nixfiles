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


  # Gets rid of some compatibility errors 
  hardware.opengl.driSupport32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  home-manager.users.toma = {
    home.packages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          libdrm
        ];
      })
    ];
  };
}
