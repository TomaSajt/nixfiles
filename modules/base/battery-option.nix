{
  flake.modules.homeManager.base =
    { lib, ... }:
    {
      options.custom.batterySupport = lib.mkEnableOption "battery support";
    };
}
