{
  flake.modules.nixos."hosts/toma-nixos-desktop-home" = {

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/adb0218f-0862-4266-98e1-79e949c3ca10";
        fsType = "ext4";
      };
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/D2A6-C5DD";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
      "/mnt/extra" = {
        device = "/dev/disk/by-uuid/ae11a0cb-ba51-4223-8fe1-6cbd9ea82b34";
        fsType = "ext4";
      };
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/e8688e0c-e780-4817-89b0-6b7d9a1cd4bc";
      }
    ];
  };
}
