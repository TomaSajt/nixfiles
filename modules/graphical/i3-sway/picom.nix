{
  flake.modules.homeManager.graphical =
    { lib, osConfig, ... }:
    {
      config = lib.mkIf (!osConfig.withWayland) {
        # Compositor (for transparency)
        services.picom = {
          enable = true;
          vSync = lib.mkDefault true;
          # Stacked transparent windows will not show behind eachother
          opacityRules = [ "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" ];
        };
      };
    };
}
