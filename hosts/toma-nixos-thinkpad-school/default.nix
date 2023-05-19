{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

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

  home-manager.users.toma = {
    home.packages = with pkgs; [ steam obs-studio ];
  };
}
