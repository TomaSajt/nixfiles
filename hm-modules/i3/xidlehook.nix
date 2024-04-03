{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.i3;

  i3lock-color = "${pkgs.i3lock-color}/bin/i3lock-color";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  colors = {
    blank = "#00000000";
    clear = "#ffffff22";
    default = "#8800FF";
    text = "#8800FF";
    wrong = "#880000";
    verifying = "#bb00bb";
    keydown = "#28FF49";
  };
  lock-args = with colors; [
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
  options.modules.i3.xidlehook = {
    enable = lib.mkEnableOption "xidlehook";
  };

  config = lib.mkIf (cfg.enable && cfg.xidlehook.enable) {
    services.xidlehook = {
      enable = true;
      not-when-audio = true;
      not-when-fullscreen = true;
      detect-sleep = true;
      timers = [
        {
          delay = 300;
          command = "${i3lock-color} ${lib.concatStringsSep " " lock-args}";
        }
        {
          delay = 1500;
          command = "${systemctl} suspend";
        }
      ];
    };
  };
}
