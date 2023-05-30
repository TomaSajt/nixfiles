{ pkgs, ... }: {
  # Compositor (for transparency)
  services.picom = {
    enable = true;
    vSync = true; # override with mkForce in host file to turn off per-machine
    opacityRules = [
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
  };
}
