{
  flake.modules.nixos."hosts/toma-nixos-server-home" =
    { pkgs, ... }:
    {
      users.users.toma.extraGroups = [ "video" ];

      services.openssh.enable = true;
      services.openssh.settings.PasswordAuthentication = false;
      services.openssh.settings.KbdInteractiveAuthentication = false;
      users.users.toma.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGt1fXoeID60m9v+mSwNmqaJ5IXdlOUeFG7YWTmnruN9 toma@toma-nixos-desktop-home"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPAndu7CnQfqEwo/jck4I7QuK6bGAMeJkA1OGdvI5iY+ u0_a158@localhost" # termux
      ];

      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      services.caddy = {
        enable = true;
        /*
          package = pkgs.caddy.withPlugins {
            plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
            hash = "sha256-j+xUy8OAjEo+bdMOkQ1kVqDnEkzKGTBIbMDVL7YDwDY=";
          };
        */
        email = "acme@tomasajt.net";
        environmentFile = "/run/keys/caddy/env_file";
        virtualHosts."files.tomasajt.net" = {
          extraConfig =
            /*
              ''
                tls {
                  dns cloudflare {env.CF_API_TOKEN}
                }
              ''
              +
            */
            ''
              reverse_proxy localhost:3210
            '';
        };
      };

      /*
        services.minecraft-server = {
          enable = true;
          eula = true;
          openFirewall = true;
          declarative = true;
          serverProperties = {
            server-port = 25565;
            difficulty = 3;
            gamemode = 1;
            max-players = 5;
            motd = "NixOS Minecraft server!";
            white-list = true;
          };
          whitelist = {
            "TomaSajt" = "9af89b10-e484-4aa7-8025-7d323c3c8992";
          };
        };
      */

      services.transmission = {
        enable = true;
        downloadDirPermissions = "770";
        settings = {
          download-dir = "/transmission/download";
          incomplete-dir = "/transmission/.incomplete";
        };
      };

      home-manager.users.toma = {
        modules.git.signing = false;
        modules.bash.color = "35";
      };
    };
}
