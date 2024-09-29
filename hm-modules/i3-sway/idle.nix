{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

let
  cfg = config.modules.i3-sway;
in
{
  options = {
    modules.i3-sway.idle = {
      enable = lib.mkEnableOption "idle";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.idle.enable) {
    services.xidlehook = lib.mkIf (!osConfig.withWayland) {
      enable = true;
      not-when-audio = true;
      not-when-fullscreen = true;
      detect-sleep = true;
      timers = [
        {
          delay = 300;
          command = config.myLockCmd;
        }
        {
          delay = 10800; # 3 hours
          command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
        }
      ];
    };

    services.swayidle = lib.mkIf osConfig.withWayland {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = config.myLockCmd;
        }
        {
          timeout = 10800; # 3 hours
          command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
        }
      ];
      extraArgs = [
        "-w"
        "-d"
      ];
    };
  };
}
