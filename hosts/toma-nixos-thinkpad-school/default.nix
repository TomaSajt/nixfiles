{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  isDesktop = true;

  boot.supportedFilesystems = [ "ntfs" ];

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/transmission/download";
      incomplete-dir = "/transmission/.incomplete";
    };
  };

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

  services.tailscale.enable = true;

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

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  home-manager.users.toma = {
    modules.alacritty.font-size = 8;
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

  hardware.graphics.enable32Bit = true;

  # Disable trackpoint (it's broken on this laptop)
  hardware.trackpoint = {
    enable = true;
    device = "TPPS/2 Elan TrackPoint";
    speed = 0;
    sensitivity = 0;
    emulateWheel = false;
  };

  # Enable touchpad support (with natural scrolling)
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
