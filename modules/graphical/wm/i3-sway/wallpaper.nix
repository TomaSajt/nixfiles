{
  flake.modules.homeManager.graphical =
    {
      lib,
      osConfig,
      ...
    }:
    {
      services.random-background = lib.mkIf (osConfig.wm == "i3") {
        enable = true;
        enableXinerama = true;
        display = "fill";
        imageDirectory = "${./wallpapers}";
        interval = "1h";
      };

      wayland.windowManager.sway.config = lib.mkIf (osConfig.wm == "sway") {
        output."*" = {
          bg = "${./wallpapers/minimalistic-1.jpg} fill";
        };
      };
    };
}
