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

      wayland.windowManager.sway = lib.mkIf osConfig.withWayland {
        config = {
          startup = [ { command = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit"; } ];
        };
      };
    };
}
