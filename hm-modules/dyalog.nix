{ inputs, lib, config, system, ... }:
let
  cfg = config.modules.dyalog;
in
{
  options.modules.dyalog = {
    enable = lib.mkEnableOption "dyalog";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with inputs.dyalog-nixos.packages.${system}; [
      dyalog
      ride
    ];
  };
}
