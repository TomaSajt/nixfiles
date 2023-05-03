{ pkgs, lib, osConfig, ... }:
let
  i3lock-color = "${pkgs.i3lock-color}/bin/i3lock-color";
  systemctl = "${osConfig.systemd.package}/bin/systemctl";
  colors = {
    blank = "#00000000";
    clear = "#ffffff22";
    default = "#8800FF";
    text = "#8800FF";
    wrong = "#880000";
    verifying = "#bb00bb";
    keydown = "#28FF49";
  };
  lock-args = with colors; lib.concatStringsSep " " [
    "--insidever-color=${clear}"
    "--ringver-color=${verifying}"
    "--insidewrong-color=${clear}"
    "--ringwrong-color=${wrong}"
    "--inside-color=${blank}"
    "--ring-color=${blank}"
    "--line-color=${blank}"
    "--separator-color=${default}"
    "--verif-color=${text}"
    "--wrong-color=${text}"
    "--time-color=${text}"
    "--date-color=${text}"
    "--layout-color=${text}"
    "--keyhl-color=${keydown}"
    "--bshl-color=${wrong}"
    "--screen 1"
    "--blur 1"
    "--clock"
    "--time-str='%H:%M:%S'"
    "--keylayout 1"
  ];
in
{
  services.xidlehook = {
    enable = true;
    not-when-audio = true;
    detect-sleep = true;
    timers = [
      {
        delay = 300;
        command = "${i3lock-color} ${lock-args}";
      }
      {
        delay = 1500;
        command = "${systemctl} suspend";
      }
    ];
  };
 }
