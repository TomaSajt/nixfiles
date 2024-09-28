{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.modules.wallpaper;
in
{
  options.modules.wallpaper = {
    enable = lib.mkEnableOption "wallpaper";
  };

  config = lib.mkIf (cfg.enable && (!osConfig.withWayland)) {
    services.random-background = {
      enable = true;
      enableXinerama = true;
      display = "fill";
      imageDirectory = "${./wallpapers}";
      interval = "1h";
    };
  };
}
