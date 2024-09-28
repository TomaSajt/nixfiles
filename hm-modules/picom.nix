{
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.modules.picom;
in
{
  options.modules.picom = {
    enable = lib.mkEnableOption "picom";
    vSync = lib.mkEnableOption "picom vSync";
  };

  config = lib.mkIf (cfg.enable && (!osConfig.withWayland)) {
    # Compositor (for transparency)
    services.picom = {
      enable = true;
      vSync = cfg.vSync;
      # Stacked transparent windows will not show behind eachother
      opacityRules = [ "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" ];
    };
  };
}
