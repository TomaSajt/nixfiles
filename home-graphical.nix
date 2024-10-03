{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.isGraphical {
    modules = lib.mkDefault {
      alacritty = {
        enable = true;
        font-size = if osConfig.withWayland then 15 else 10;
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
      i3-sway = {
        enable = true;
        show-battery = true;
        idle.enable = true;
        autorandr.enable = true;
        wallpaper.enable = true;
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
      discord # Online Chat - UNFREE
      obsidian # Note-taking - UNFREE
      element-desktop

      ani-cli
      mpv

      gparted
      quark-goldleaf

      gimp
      inkscape
      libsForQt5.filelight

      nix-tree
      nix-du
      graphviz

      xdg-utils

      nix-update
    ];
  };
}
