{
  flake.modules.nixos.graphical =
    { pkgs, config, ... }:
    {
      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-xapp
          pkgs.xdg-desktop-portal-wlr
          pkgs.xdg-desktop-portal-luminous
        ];

        config = {
          "i3" = {
            "default" = [
              "gtk"
              "xapp"
            ];
          };
          "sway" = {
            "default" = [
              "gtk"
              "wlr"
              "luminous"
            ];
            "org.freedesktop.portal.RemoteDesktop" = [ "luminous" ];
          };
        };
      };
    };
}
