{ config, pkgs, ...}:

{
  imports = [
    ../hardware/desktop.nix
    ../base.nix
  ];

  networking.hostName = "toma-nixos-desktop";
}
