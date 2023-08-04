{ lib, config, ... }:

with lib;

let
  cfg = config.modules.picom;
in
{
  options.modules.picom = {
    enable = mkEnableOption "picom";
    vSync = mkEnableOption "picom vSync";
  };

  config = mkIf cfg.enable {
    # Compositor (for transparency)
    services.picom = {
      enable = true;
      vSync = cfg.vSync;
      # Stacked transparent windows will not show behind eachother
      opacityRules = [
        "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      ];
    };
  };
}
