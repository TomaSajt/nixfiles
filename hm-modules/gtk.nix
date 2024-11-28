{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.gtk;
in
{
  options.modules.gtk = {
    enable = lib.mkEnableOption "GTK";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.lxappearance ]; # Look at themes (just don't switch them pls)

    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-blue-compact+rimless";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "mocha";
        };
      };
      cursorTheme = {
        name = "volantes_cursors";
        package = pkgs.volantes-cursors;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        "color-scheme" = "prefer-dark";
      };
    };
  };
}
