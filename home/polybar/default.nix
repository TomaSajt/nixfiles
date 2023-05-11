{ pkgs, config, ... }:
{
  services.polybar = {
    enable = true;
    package = pkgs.unstable.polybar.override {
      pulseSupport = true;
      i3Support = true;
      i3 = config.xsession.windowManager.i3.package;
    };
    settings = import ./settings.nix;
    script = ''
      polybar top &
    '';
  };

  systemd.user.services.polybar = {
    Install.WantedBy = [ "graphical-session.target" ];
  };

}
