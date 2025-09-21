{
  flake.modules.nixos."hosts/toma-nixos-probook" = {

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/65c53fa9-4f3f-45ea-9f0e-bd0d97f508cc";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/E374-E30B";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };
    };

    boot.initrd.luks.devices = {
      "luks-e04bca55-7792-47f1-afe8-5b0b9205aca0" = {
        device = "/dev/disk/by-uuid/e04bca55-7792-47f1-afe8-5b0b9205aca0";
      };
      "luks-30434f9d-0a68-4641-bab8-b9292d590654" = {
        device = "/dev/disk/by-uuid/30434f9d-0a68-4641-bab8-b9292d590654";
      };
    };

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/5c8ddb55-8dfe-491a-ba12-c47997514559";
      }
    ];
  };
}
