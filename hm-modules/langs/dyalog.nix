{ pkgs, lib, config, ... }:
let
  cfg = config.modules.langs.dyalog;
in
{
  options.modules.langs.dyalog = {
    enable = lib.mkEnableOption "dyalog";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dyalog
      dev-ride.ride
    ];
  };
}
