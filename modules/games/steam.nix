{
  flake.modules.nixos.games = {
    hardware.steam-hardware.enable = true;
  };

  flake.modules.homeManager.games =
    {
      pkgs,
      ...
    }:
    let
      steam = pkgs.steam.override { };
    in
    {
      home.packages = [
        steam
        steam.run
        pkgs.steamcmd
        pkgs.protontricks
      ];
    };
}
