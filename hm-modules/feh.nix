{ lib, config, ... }:
let
  cfg = config.modules.feh;
in
{
  options.modules.feh = {
    enable = lib.mkEnableOption "feh";
  };

  config = lib.mkIf cfg.enable {
    modules.mime-apps.associations = {
      "image/jpeg" = "feh.desktop";
    };

    programs.feh = {
      enable = true;
    };
  };
}
