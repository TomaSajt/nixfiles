{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable touchpad support (with natural scrolling)
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
