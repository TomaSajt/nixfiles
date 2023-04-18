{ pkgs, osConfig, ... }:
let
  i3lock-fancy = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
  systemctl = "${osConfig.systemd.package}/bin/systemctl";
in
{
  services.xidlehook = {
    enable = true;
    not-when-audio = true;
    detect-sleep = true;
    timers = [
      {
        delay = 300;
        command = "${i3lock-fancy}";
      }
      {
        delay = 1500;
        command = "${systemctl} suspend";
      }
    ];
  };
}
