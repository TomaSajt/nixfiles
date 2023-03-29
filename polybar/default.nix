{ pkgs, ... }:
{
  home-manager.users.toma = {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
      };
      settings = import ./settings.nix;
      script = "polybar top &";
    };

    systemd.user.services.polybar = {
      Install.WantedBy = [ "graphical-session.target" ];
    };

  };
}

