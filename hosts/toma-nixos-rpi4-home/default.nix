{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ./blocky.nix
  ];

  home-manager.users.toma = {
    modules.langs.dyalog.enable = false;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking.wireless = {
    enable = false;
    interfaces = [ "wlan0" ];
    networks = {
      #"foobar".psk = "????";
    };
  };

  services.openssh.enable = true;
}
