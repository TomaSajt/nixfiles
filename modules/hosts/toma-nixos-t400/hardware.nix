{
  flake.modules.nixos."hosts/toma-nixos-t400" =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      nixpkgs.hostPlatform = "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      boot.initrd.availableKernelModules = [
        "uhci_hcd"
        "ehci_pci"
        "ata_piix"
        "firewire_ohci"
        "usb_storage"
        "sd_mod"
        "sr_mod"
        "sdhci_pci"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

    };
}
