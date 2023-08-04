{ pkgs, lib, config, ... }:
let
  cfg = config.modules.thunar;
in
{
  options.modules.thunar = {
    enable = lib.mkEnableOption "thunar";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.xfce.thunar ];
    modules.mime-apps.associations = {
      "inode/directory" = "thunar.desktop";
    };
  };
}
