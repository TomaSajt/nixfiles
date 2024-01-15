{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.supportedFilesystems = [ "ntfs" ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/transmission/download";
      incomplete-dir = "/transmission/.incomplete";
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureUsers = [{
      name = "toma";
      ensurePermissions = { "*.*" = "ALL"; };
    }];
  };

  home-manager.users.toma = {
    home.packages = with pkgs; [
      mysql-workbench
    ];
  };

  networking.firewall = {
    allowedUDPPorts = [ 7777 25565 ];
    allowedTCPPorts = [ 7777 25565 ];
  };

  hardware.opengl.driSupport32Bit = true;

  # Disable trackpoint (it's broken on this laptop)
  hardware.trackpoint = {
    enable = true;
    device = "TPPS/2 Elan TrackPoint";
    speed = 0;
    sensitivity = 0;
    emulateWheel = false;
  };

  # Enable touchpad support (with natural scrolling)
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
