{
  flake.modules.homeManager.graphical =
    {
      lib,
      osConfig,
      ...
    }:
    {
      services.random-background = lib.mkIf (!osConfig.withWayland) {
        enable = true;
        enableXinerama = true;
        display = "fill";
        imageDirectory = "${./wallpapers}";
        interval = "1h";
      };

      wayland.windowManager.sway.config = lib.mkIf osConfig.withWayland {
        output."*" = {
          bg = "${./wallpapers/minimalistic-1.jpg} fill";
        };
      };
    };
}
