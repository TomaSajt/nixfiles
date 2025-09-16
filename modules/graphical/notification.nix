{
  flake.modules.homeManager.graphical =
    {
      lib,
      config,
      ...
    }:

    let
      full = "99";
      warning = "15";
      critical = "5";
      danger = "2";
    in
    {
      services.dunst.enable = true;

      services.batsignal = lib.mkIf config.custom.batterySupport {
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
