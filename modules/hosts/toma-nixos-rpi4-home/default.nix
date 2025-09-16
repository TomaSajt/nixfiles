{ inputs, config, ... }:
{
  flake.modules.nixos."hosts/toma-nixos-rpi4-home" =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with config.flake.modules.nixos; [
        base
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
      ];

      home-manager.users.toma = {
        imports = with config.flake.modules.homeManager; [
          base
        ];
      };

      nixpkgs.hostPlatform = "aarch64-linux";

      home-manager.users.toma = {
        modules.langs.dyalog.enable = false;
        modules.git.signing = false;
        modules.bash.color = "35";
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
      services.tailscale.enable = true;
    };
}
