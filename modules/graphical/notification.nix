{
  flake.modules.homeManager.graphical =
    {
      lib,
      config,
      ...
    }:

    let
      warning = "15";
      critical = "5";
      danger = "2";
    in
    {
      #services.dunst.enable = true;
      services.mako = {
        enable = true;
        settings = {
          "default-timeout" = 10000;
        };
      };

      services.batsignal = lib.mkIf config.custom.batterySupport {
        enable = true;
        extraArgs = [
          "-e"
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
