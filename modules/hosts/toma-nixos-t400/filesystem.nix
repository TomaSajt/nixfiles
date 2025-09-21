{
  flake.modules.nixos."hosts/toma-nixos-t400" = {

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Setup keyfile
    boot.initrd.secrets = {
      "/boot/crypto_keyfile.bin" = null;
    };

    boot.loader.grub.enableCryptodisk = true;

    boot.initrd.luks.devices = {
      "luks-f5cc51d2-0d40-427f-ad3e-09dbe5393364" = {
        device = "/dev/disk/by-uuid/f5cc51d2-0d40-427f-ad3e-09dbe5393364";
        keyFile = "/boot/crypto_keyfile.bin";
      };
      "luks-bd05bf5e-e927-4514-ad1b-ac4653bdb734" = {
        device = "/dev/disk/by-uuid/bd05bf5e-e927-4514-ad1b-ac4653bdb734";
        keyFile = "/boot/crypto_keyfile.bin";
      };
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/c739f315-e271-4035-b5e4-a0126285dd42";
      fsType = "ext4";
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/f59b2e0e-ddda-469c-97ae-c33fbaaec59b";
      }
    ];
  };
}
