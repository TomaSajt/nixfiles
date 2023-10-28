{ pkgs, lib, config, ... }:

let
  cfg = config.modules.games.osu;
in

{
  options.modules.games.osu = {
    enable = lib.mkEnableOption "osu";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      osu-lazer-bin
      osu-mime-types
    ];

    modules.mime-apps.associations = {
      "application/x-osu-beatmap-archive" = "osu!.desktop";
      "application/x-osu-skin-archive" = "osu!.desktop";
      "application/x-osu-beatmap" = "osu!.desktop";
      "application/x-osu-replay" = "osu!.desktop";
    };
  };
}
