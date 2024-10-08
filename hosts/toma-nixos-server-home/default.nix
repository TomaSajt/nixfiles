{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./fbterm.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  users.users.toma.extraGroups = [ "video" ];

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;
  users.users.toma.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGt1fXoeID60m9v+mSwNmqaJ5IXdlOUeFG7YWTmnruN9 toma@toma-nixos-desktop-home"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBeNXRcTFAHC2AHFQhsV4bw0yuouPlKcxrmq6Z6QRdqV toma@toma-nixos-thinkpad-school"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPAndu7CnQfqEwo/jck4I7QuK6bGAMeJkA1OGdvI5iY+ u0_a158@localhost" # termux
  ];

  environment.systemPackages = with pkgs; [ ];

  home-manager.users.toma = {
    modules.git.signing = false;
    modules.gpg.enable = false;
    modules.bash.color = "35";
  };

  services.tailscale.enable = true;

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
}
