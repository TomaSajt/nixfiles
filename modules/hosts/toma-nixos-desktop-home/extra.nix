{ inputs, ... }:
{
  nixpkgs.allowedUnfreePackages = [
    "terraria-server"
  ];

  flake.modules.nixos."hosts/toma-nixos-desktop-home" =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      custom.tailscale.enableNMWorkaround = true;

      services.transmission = {
        enable = true;
        package = pkgs.transmission_4;
        downloadDirPermissions = "770";
        settings = {
          download-dir = "/mnt/extra/transmission/download";
          incomplete-dir = "/mnt/extra/transmission/.incomplete";
        };
      };

      services.udev.packages = [ pkgs.quark-goldleaf ];

      /*
          disabledModules = [ "services/games/terraria.nix" ];

          imports = [ "${inputs.nixpkgs-terraria}/nixos/modules/services/games/terraria.nix" ];

          services.terraria = {
            enable = true;
            port = 7776;
            worldPath = "/var/lib/terraria/.local/share/Terraria/Worlds/asd.wld";
            autocreate = {
              enable = true;
            };
          };
      */

      /*
        services.mysql = {
          enable = true;
          package = pkgs.mariadb;
          ensureUsers = [
            {
              name = "toma";
              ensurePermissions = {
                "*.*" = "ALL";
              };
            }
          ];
          ensureDatabases = [ "spn-db" ];
        };

        fileSystems."/mnt/spn_shm" = {
          device = "none";
          fsType = "tmpfs";
          options = [
            "size=1G"
            "noexec"
            "uid=toma"
          ];
        };
      */

      /*
        services.lanraragi = {
          enable = true;
          port = 3001;
          passwordFile = pkgs.writeText "pass" "password";
          package =
            let
              pkgs-lanraragi = import inputs.nixpkgs-lanraragi { system = pkgs.hostPlatform.system; };
            in
            pkgs-lanraragi.lanraragi.overrideAttrs (prev: { });
          };
      */

      services.speechd.enable = true;

      networking.firewall = {
        allowedUDPPorts = [
          7777
          25565
          45000
          45001
        ];
        allowedTCPPorts = [
          7777
          25565
          45000
          45001
        ];
      };

    };
}
