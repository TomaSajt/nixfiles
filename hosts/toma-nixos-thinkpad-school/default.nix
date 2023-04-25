{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable touchpad support (with natural scrolling)
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  home-manager.users.toma = {
    services.picom.vSync = true;
  };
}
