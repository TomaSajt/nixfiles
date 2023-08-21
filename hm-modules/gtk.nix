{ pkgs, lib, config, ... }:
let
  cfg = config.modules.gtk;
in
{
  options.modules.gtk = {
    enable = lib.mkEnableOption "GTK";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.lxappearance ]; # Look at themes (just don't switch them)

    gtk = {
      enable = true;
      theme = {
        # it says light, but it's actually dark
        name = "Catppuccin-Latte-Compact-Blue-Light";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          size = "compact";
          tweaks = [ "rimless" /*"black"*/ ];
          variant = "latte";
        };
      };
      cursorTheme = {
        name = "Catppuccin-Latte-Dark-Cursors";
        package = pkgs.catppuccin-cursors.latteDark;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
        gtk-cursor-theme-size = 0;
      };
    };
  };
}