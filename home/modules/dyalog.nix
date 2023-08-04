{ inputs, lib, config, system, ... }:

with lib;

let
  cfg = config.modules.dyalog;
in
{
  options.modules.dyalog = {
    enable = mkEnableOption "dyalog";
  };

  config = mkIf cfg.enable {
    home.packages = with inputs.dyalog-nixos.packages.${system}; [
      dyalog
      ride
    ];
  };
}
