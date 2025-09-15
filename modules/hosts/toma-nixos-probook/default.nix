{ config, ... }:
{
  flake.modules.nixos."hosts/toma-nixos-probook" =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with config.flake.modules.nixos; [
        base
        ../../..
      ];

      home-manager.users.toma = {
        imports = with config.flake.modules.homeManager; [
          base
          fcitx5
        ];
      };

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
    };
}
