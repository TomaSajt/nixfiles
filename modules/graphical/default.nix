{
  flake.modules.nixos.graphical =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    {
      options = {
        withWayland = lib.mkEnableOption "wayland";
      };

      config = {
        withWayland = lib.mkDefault true;
        specialisation."x11".configuration = {
          withWayland = false;
        };

        hardware.graphics.enable = true; # otherwise sway doesn't start
        hardware.graphics.enable32Bit = true;

        # Secrets management or something
        services.gnome.gnome-keyring.enable = true;
        programs.seahorse.enable = true;

        # Enable networking
        networking.networkmanager.enable = true;

        # Some config support or something
        programs.dconf.enable = true;

        # Some kind of accessibility thingy, makes a warning go away
        services.gnome.at-spi2-core.enable = true;

        # https://wiki.nixos.org/wiki/MTP
        services.gvfs.enable = true;

        /*
          services.udev = {
            extraRules = ''
              # Label Printer
              SUBSYSTEM=="usb", ATTRS{idVendor}=="0471", ATTRS{idProduct}=="0055", MODE="0666"
            '';
          };
        */
      };
    };

  flake.modules.homeManager.graphical =
    {
      pkgs,
      lib,
      ...
    }:
    {
      # Network Applet
      services.network-manager-applet.enable = true;

      # Audio Applet
      # services.pasystray.enable = true;
    };
}
