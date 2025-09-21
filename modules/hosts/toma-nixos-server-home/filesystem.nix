{
  flake.modules.nixos."hosts/toma-nixos-server-home" = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/e4c806b8-ce22-4f52-9218-2d5d78290da4";
        fsType = "ext4";
      };
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/416B-CF36";
        fsType = "vfat";
      };
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/67ee282f-f80b-4852-afac-eb988cf9d252";
      }
    ];
  };
}
