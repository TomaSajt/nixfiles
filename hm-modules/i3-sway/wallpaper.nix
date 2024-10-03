{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.modules.i3-sway;
in
{
  options.modules.i3-sway.wallpaper = {
    enable = lib.mkEnableOption "wallpaper";
  };

  config = lib.mkIf (cfg.enable && cfg.wallpaper.enable) {
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
