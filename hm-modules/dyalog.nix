{ pkgs, lib, config, ... }:
let
  cfg = config.modules.dyalog;
in
{
  options.modules.dyalog = {
    enable = lib.mkEnableOption "dyalog";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.dev2.dyalog-apl
      pkgs.dev1.ride
    ];
  };
}
