{ pkgs, config, lib, ... }:
let
  mkStats = packageList:
    let
      packages = builtins.map (p: "${p.name}") packageList;
      sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
in
{
  environment.etc = {
    "current-system-packages".text = mkStats config.environment.systemPackages;
    "current-home-packages".text = mkStats config.home-manager.users.toma.home.packages;
  };
}
