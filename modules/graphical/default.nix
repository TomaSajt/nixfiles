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

        services.xserver = lib.mkIf (!config.withWayland) {
          enable = true;
          windowManager.i3.enable = true;
          xkb.layout = "hu";
        };

        services.displayManager.defaultSession = lib.mkIf (!config.withWayland) "none+i3";

        environment.loginShellInit = lib.mkIf config.withWayland ''
          # load home manager env
          . ~/.profile

          if [ -z "$WAYLAND_DISPLAY" ]  && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
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

        hardware.steam-hardware.enable = true;

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

        # Needed for udiskie to work (in home-manager configs)
        services.udisks2.enable = true;

        # https://wiki.nixos.org/wiki/MTP
        services.gvfs.enable = true;

        # Enable sound with pipewire.
        security.rtkit.enable = true;

        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };

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
    };

  flake.modules.homeManager.graphical =
    {
      pkgs,
      lib,
      osConfig,
      ...
    }:
    {
      modules = lib.mkDefault {
        vscode = {
          enable = true;
          codium = true;
        };
        firefox.enable = true;
        games = {
          heroic.enable = true;
          minecraft.enable = true;
          osu.enable = true;
          steam.enable = true;
          wine.enable = true;
        };
        mime-apps.enable = true;
        notification = {
          enable = true;
          battery = true;
        };
        obs-studio.enable = true;
        picom = {
          enable = true;
          vSync = true;
        };
        thunar.enable = true;
      };

      # Network Applet
      services.network-manager-applet.enable = true;

      # Audio Applet
      services.pasystray.enable = true;

      home.packages = with pkgs; [
        discord # UNFREE
        obsidian # UNFREE
        element-desktop

        ani-cli
        mpv

        gparted

        gimp
        inkscape

        nix-tree
        nix-du
        graphviz

        btop

        xdg-utils

        nix-update
        nixpkgs-review
      ];
    };
}
