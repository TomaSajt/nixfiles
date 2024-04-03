{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.games.steam;

  steam = pkgs.steam.override { };
in
{
  options.modules.games.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      steam
      steam.run
      pkgs.protontricks
    ];
  };
}
