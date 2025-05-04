{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    isGraphical = lib.mkEnableOption "graphical config";
    withWayland = lib.mkEnableOption "wayland";
  };

  config = lib.mkIf config.isGraphical {

    withWayland = lib.mkDefault true;
    specialisation."x11".configuration = {
      withWayland = false;
    };

    services.xserver = lib.mkIf (!config.withWayland) {
      enable = true;
      windowManager.i3.enable = true;
      xkb.layout = "hu";
    };

    services.displayManager.defaultSession = lib.mkIf (!config.withWayland) "none+i3";

    environment.loginShellInit = lib.mkIf config.withWayland ''
      # load home manager env
      . ~/.profile

      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          sway --unsupported-gpu
      fi
    '';

    # configure what can handle authentication
    security.pam.services = {
      "swaylock" = lib.mkIf config.withWayland { };
      "i3lock" = lib.mkIf (!config.withWayland) { };
    };

    xdg.portal.enable = true;
    xdg.portal.configPackages = [
      pkgs.xdg-desktop-portal-gtk
      (if config.withWayland then pkgs.xdg-desktop-portal-wlr else pkgs.xdg-desktop-portal-xapp)
    ];

    programs.quark-goldleaf.enable = true;

    hardware.steam-hardware.enable = true;

    hardware.graphics.enable = true; # otherwise sway doesn't start
    hardware.graphics.enable32Bit = true;

    # hardware.opentabletdriver.enable = true;

    # Secrets management or something
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Some config support or something
    programs.dconf.enable = true;

    # Some kind of accessibility thingy, makes a warning go away
    services.gnome.at-spi2-core.enable = true;

    # Needed for udiskie to work (in home-manager configs)
    services.udisks2.enable = true;

    # Enable support for Nintendo Pro Controllers and Joycons
    # services.joycond.enable = true;

    # Enable sound with pipewire.
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # hardware.alsa.enablePersistence = true;
    # hardware.alsa.enable = true;

    /*
      security.polkit = {
        enable = true;
        debug = true;
      };

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    */

    services.udev = {
      packages = with pkgs; [ ];
      extraRules = ''
        # Backlight permissions
        # ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"

        # Label Printer
        # SUBSYSTEM=="usb", ATTRS{idVendor}=="0471", ATTRS{idProduct}=="0055", MODE="0666"
      '';
    };
  };
}
