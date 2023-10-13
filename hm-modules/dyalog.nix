{ pkgs, lib, config, ... }:
let
  cfg = config.modules.dyalog;
in
{
  options.modules.dyalog = {
    enable = lib.mkEnableOption "dyalog";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dyalog
      dev1.ride
    ];
  };
}
