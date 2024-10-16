{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  isGraphical = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/transmission/download";
      incomplete-dir = "/transmission/.incomplete";
    };
  };

  /*
    services.lanraragi.enable = true;
    services.lanraragi.port = 3001;
    services.lanraragi.package = pkgs.lanraragi.overrideAttrs (prev: {
      patchesx = [ ./a.patch ] ++ (prev.patches or [ ]);
      checkPhase = "";
    });
  */

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

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [
        ""
        "${pkgs.networkmanager}/bin/nm-online -q"
      ];
    };
  };

  services.tailscale.enable = true;

  /*
      services.nginx = {
        enable = true;

        virtualHosts."100.84.206.46" = {
          listen = [
            {
              port = 3000;
              addr = "100.84.206.46";
            }
          ];
          locations = {
            "/static/" = {
              alias = "/var/www/spn/staticfiles/";
            };
            "/websocket" = {
              proxyPass = "http://127.0.0.1:9009";
              extraConfig = ''
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "Upgrade";
              '';
            };
            "/" = {
              proxyPass = "http://127.0.0.1:8000";
            };
          };

        };
      };

    users.users.spn-user = {
      isNormalUser = true;
      group = "spn-user";
    };

    users.groups.spn-user = { };

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

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  home-manager.users.toma = {
    modules.alacritty.font-size = if config.withWayland then 12 else 8;
    modules.fcitx5.enable = true;
    home.packages = [ ];
  };

  networking.firewall = {
    allowedUDPPorts = [
      7777
      25565
      3000
    ];
    allowedTCPPorts = [
      7777
      25565
      3000
    ];
  };

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="input", ATTR{name}=="TPPS/2 Elan TrackPoint", ATTR{device/speed}="0", ATTR{device/sensitivity}="0"
    ACTION=="add|change", SUBSYSTEM=="input", ATTR{name}=="PS/2 Generic Mouse", ATTR{device/speed}="0", ATTR{device/sensitivity}="0"
  '';

  # Enable touchpad support (with natural scrolling)
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
