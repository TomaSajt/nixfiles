{ config, pkgs, ...}:

{
  imports = [
    ../hardware/desktop.nix
    ../base.nix
  ];

  networking.hostName = "toma-nixos-desktop";
  home-manager.users.toma = {
    home.packages = with pkgs; [ ];
  };
  # services.xserver.videoDrivers = [ "nvidia" ];
}
