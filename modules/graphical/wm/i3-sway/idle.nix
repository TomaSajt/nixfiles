{
  flake.modules.homeManager.graphical =
    {
      pkgs,
      lib,
      config,
      osConfig,
      ...
    }:
    {
      services.xidlehook = lib.mkIf (osConfig.wm == "i3") {
        enable = true;
        not-when-audio = true;
        not-when-fullscreen = true;
        detect-sleep = true;
        timers = [
          {
            delay = 600;
            command = config.myLockCmd;
          }
          /*
            {
              delay = 10800; # 3 hours
              command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
            }
          */
        ];
      };

      services.swayidle = lib.mkIf (osConfig.wm == "sway") {
        enable = true;
        timeouts = [
          {
            timeout = 600;
            command = config.myLockCmd;
          }
          /*
            {
              timeout = 10800; # 3 hours
              command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
            }
          */
        ];
        extraArgs = [
          "-w"
          "-d"
        ];
      };

      wayland.windowManager.sway = lib.mkIf (osConfig.wm == "sway") {
        config = {
          startup = [ { command = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit"; } ];
        };
      };
    };
}
