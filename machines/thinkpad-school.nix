{ config, pkgs, ...}:

{
  imports = [
    ../hardware/thinkpad-school.nix
    ../base.nix
  ];

  networking.hostName = "toma-nixos-thinkpad-school";
}
