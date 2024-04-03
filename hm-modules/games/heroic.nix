{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.games.heroic;

  heroic = pkgs.heroic.override { };
in
{
  options.modules.games.heroic = {
    enable = lib.mkEnableOption "heroic";
  };

  config = lib.mkIf cfg.enable { home.packages = [ heroic ]; };
}
