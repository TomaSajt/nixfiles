{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    isGraphical = lib.mkEnableOption "graphical config";
  };

  config = lib.mkIf config.isGraphical {

    services.xserver = {
      enable = lib.mkDefault true;
      windowManager.i3.enable = true;
      xkb.layout = "hu";
    };

    services.displayManager.defaultSession = "none+i3";

    programs.quark-goldleaf.enable = true;

    hardware.steam-hardware.enable = true;

    hardware.graphics.enable32Bit = true;

    hardware.opentabletdriver.enable = true;

    # Secrets management or something
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Some config support or something
    programs.dconf.enable = true;

    # Some kind of accessibility thingy, makes a waring go away
    services.gnome.at-spi2-core.enable = true;

    # Needed for udiskie to work (in home-manager configs)
    services.udisks2.enable = true;

    # Enable support for Nintendo Pro Controllers and Joycons
    services.joycond.enable = true;

    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware.alsa.enablePersistence = true;

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

    services.udev = {
      packages = with pkgs; [ ];
      extraRules = ''
        # Backlight permissions
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"

        # Label Printer
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0471", ATTRS{idProduct}=="0055", MODE="0666"
      '';
    };
  };
}
