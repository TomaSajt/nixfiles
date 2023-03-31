{ ... }:

{
  imports = [
    ../../base.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "toma-nixos-thinkpad-school";
}
