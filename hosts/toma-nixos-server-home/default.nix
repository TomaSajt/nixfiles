{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  services.getty.autologinUser = "toma";

  users.users.toma.extraGroups = [ "video" ];

  security.wrappers.fbterm = {
    source = "${pkgs.fbterm}/bin/fbterm";
    owner = "nobody";
    group = "nogroup";
    capabilities = "cap_sys_tty_config+ep";
  };

  environment = {
    loginShellInit = "fbterm --font-size=18";
    systemPackages = with pkgs; [ ];
  };

  home-manager.users.toma = {
    modules.git.signing = false;
    modules.gpg.enable = false;
  };

  services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
      download-dir = "/transmission/download";
      incomplete-dir = "/transmission/.incomplete";
    };
  };

  
}
