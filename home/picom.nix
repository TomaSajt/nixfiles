{ pkgs, ... }: {
  # Compositor (for transparency)
  services.picom = {
    enable = true;
    vSync = true; # override with mkForce in host file to turn off per-machine
  };
}
