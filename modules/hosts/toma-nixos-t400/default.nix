{ config, ... }:
{
  flake.modules.nixos."hosts/toma-nixos-t400" =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with config.flake.modules.nixos; [
        base
      ];

      home-manager.users.toma = {
        imports = with config.flake.modules.homeManager; [
          base
        ];
      };


  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.initrd.luks.devices."luks-f5cc51d2-0d40-427f-ad3e-09dbe5393364".device = "/dev/disk/by-uuid/f5cc51d2-0d40-427f-ad3e-09dbe5393364";
  # Setup keyfile
  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-bd05bf5e-e927-4514-ad1b-ac4653bdb734".keyFile = "/boot/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-f5cc51d2-0d40-427f-ad3e-09dbe5393364".keyFile = "/boot/crypto_keyfile.bin";
  networking.networkmanager.enable = true;
    };
}
