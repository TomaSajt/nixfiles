{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config =
    let
      predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
    in
    {
      flake.modules.nixos.base = {
        nixpkgs.config.allowUnfreePredicate = predicate;
      };
    };
}
