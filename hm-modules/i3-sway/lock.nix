{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
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
  pidof = lib.getExe' pkgs.procps "pidof";
in
{
  options = {
    myLockCmd = lib.mkOption {
      type = lib.types.str;
      default =
        if osConfig.withWayland then
          "${lib.getExe pkgs.swaylock} -f"
        else
          "${pidof} i3lock-color || ${lib.getExe' pkgs.i3lock-color "i3lock-color"} ${lib.concatStringsSep " " lock-args}";
    };
  };
  config = {
    programs.swaylock = lib.mkIf osConfig.withWayland {
      enable = true;
      settings = {
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "ffffff";
        show-failed-attempts = true;
      };
    };
  };
}
