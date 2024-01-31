{ inputs, pkgs, lib, config, ... }:

{
  options = {
    isDesktop = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf config.isDesktop {
    fonts = {
      fontDir.enable = true;
      fontconfig.defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "Uiua386" ];
      };
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        uiua386
      ];
    };

    services.xserver = {
      enable = lib.mkDefault true;
      windowManager.i3.enable = true;
      displayManager.defaultSession = "none+i3";
    };

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

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

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
      packages = with pkgs; [ dev2.quark-goldleaf ];
      extraRules = ''
        # Backlight permissions
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"

        KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
      '';
    };
  };
}
