{
  flake.modules.homeManager.games =
    {
      pkgs,
      ...
    }:
    let
      heroic = pkgs.heroic.override { };
    in
    {
      home.packages = [ heroic ];
    };
}
