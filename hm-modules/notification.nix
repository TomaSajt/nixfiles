{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.notification;

  full = "99";
  warning = "15";
  critical = "5";
  danger = "2";
in
{
  options.modules.notification = {
    enable = lib.mkEnableOption "notification";
    battery = lib.mkEnableOption "battery notification";
  };

  config = lib.mkIf cfg.enable {
    services.dunst.enable = true;
    services.batsignal = lib.mkIf cfg.battery {
      enable = true;
      extraArgs = [
        "-e"
        "-f"
        full
        "-w"
        warning
        "-c"
        critical
        "-d"
        danger
      ];
    };
  };
}
