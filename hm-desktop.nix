{ pkgs, lib, osConfig, ... }:
{
  config = lib.mkIf osConfig.isDesktop {
    modules = lib.mkDefault {
      alacritty = {
        enable = true;
        font-size = 10.0;
      };
      code-editors = {
        vscode = {
          enable = true;
          codium = true;
        };
      };
      feh.enable = true;
      firefox.enable = true;
      games = {
        heroic.enable = true;
        minecraft.enable = true;
        osu.enable = true;
        steam.enable = true;
        wine.enable = true;
      };
      gtk.enable = true;
      i3 = {
        enable = true;
        show-battery = true;
        xidlehook.enable = true;
        autorandr.enable = true;
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
      wallpaper.enable = true;
    };

    # Network Applet
    services.network-manager-applet.enable = true;

    # Audio Applet
    services.pasystray.enable = true;

    home.packages = with pkgs; [
      discord # Online Chat - UNFREE
      dev3.obsidian # Note-taking - UNFREE
      element-desktop

      ani-cli
      mpv

      gparted
      dev2.quark-goldleaf

      gimp
      inkscape
      jasp-desktop
      libsForQt5.filelight
    ];
  };
}
