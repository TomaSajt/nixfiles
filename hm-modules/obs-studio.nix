{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.obs-studio;
in
{
  options.modules.obs-studio = {
    enable = lib.mkEnableOption "OBS Studio";
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ ];
    };
  };
}
