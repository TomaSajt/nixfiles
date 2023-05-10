{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    package = pkgs.unstable.polybarFull;
    settings = import ./settings.nix;
    script = "polybar top &";
  };

  systemd.user.services.polybar = {
    Install.WantedBy = [ "graphical-session.target" ];
  };

}
