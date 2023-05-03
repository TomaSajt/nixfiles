{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # Enable touchpad support (with natural scrolling)
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  home-manager.users.toma = {
    home.packages = with pkgs; [ steam ];
  };
}
