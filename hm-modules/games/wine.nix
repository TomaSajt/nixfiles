{ pkgs, lib, config, ... }:
let
  cfg = config.modules.games.wine;
in
{
  options.modules.games.wine = {
    enable = lib.mkEnableOption "wine";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.wine
    ];
  };
}
