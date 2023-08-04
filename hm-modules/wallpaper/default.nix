{ pkgs, lib, config, ... }:
let
  cfg = config.modules.wallpaper;
in
{
  options.modules.wallpaper = {
    enable = lib.mkEnableOption "wallpaper";
  };

  config = lib.mkIf cfg.enable {
    services.random-background = {
      enable = true;
      enableXinerama = true;
      display = "fill";
      imageDirectory = "${./wallpapers}";
      interval = "1h";
    };
  };
}
