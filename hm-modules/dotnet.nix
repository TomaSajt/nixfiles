{ pkgs, lib, config, ... }:

let
  cfg = config.modules.dotnet;

  dotnet-sdks = with pkgs.dotnetCorePackages; combinePackages [
    sdk_6_0
    sdk_7_0
    sdk_8_0
  ];
in
{
  options.modules.dotnet = {
    enable = lib.mkEnableOption "dotnet";
  };

  config = lib.mkIf cfg.enable {
    home = {
      sessionVariables = {
        DOTNET_CLI_TELEMETRY_OPTOUT = "true";
      };
      packages = [ dotnet-sdks ];
    };
  };
}
