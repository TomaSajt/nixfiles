{
  flake.modules.nixos.base = {
    services.udisks2.enable = true;
  };

  flake.modules.homeManager.base = {
    # Automatic external disk mounting to /var/run/mount
    services.udiskie = {
      enable = true;
      tray = "auto";
    };
  };
}
