{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.toma = {
    services.picom.vSync = true;
  };
}
