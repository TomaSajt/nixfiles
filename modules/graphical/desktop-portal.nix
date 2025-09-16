{
  flake.modules.nixos.graphical =
    { pkgs, config, ... }:
    {
      xdg.portal.enable = true;
      xdg.portal.configPackages = [
        pkgs.xdg-desktop-portal-gtk
        (if config.withWayland then pkgs.xdg-desktop-portal-wlr else pkgs.xdg-desktop-portal-xapp)
      ];
    };
}
