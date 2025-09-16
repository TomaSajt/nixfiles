{
  flake.modules.homeManager.games =
    {
      pkgs,
      ...
    }:
    {
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
