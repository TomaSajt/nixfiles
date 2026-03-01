{
  flake.modules.nixos.graphical =
    { pkgs, config, ... }:
    {
      xdg.portal.enable = true;
      xdg.portal.configPackages = [
        pkgs.xdg-desktop-portal-gtk
        (if config.wm == "i3" then pkgs.xdg-desktop-portal-xapp else pkgs.xdg-desktop-portal-wlr)
      ];
    };
}
