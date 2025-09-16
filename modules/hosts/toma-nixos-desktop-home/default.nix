{ config, ... }:
{
  flake.modules.nixos."hosts/toma-nixos-desktop-home" =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with config.flake.modules.nixos; [
        base
        graphical
      ];

      home-manager.users.toma = {
        imports = with config.flake.modules.homeManager; [
          base
          graphical
        ];
      };

      # Bootloader
      boot.loader = {
        systemd-boot.enable = true;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
      };

      boot.supportedFilesystems = [ "ntfs" ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.br-8d9b12564c54.useDHCP = lib.mkDefault true;
      # networking.interfaces.br-fd1b6e45a52e.useDHCP = lib.mkDefault true;
      # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
      # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

    };
}
