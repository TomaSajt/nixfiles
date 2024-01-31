{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];
  /*
    services.transmission = {
    enable = true;
    downloadDirPermissions = "770";
    settings = {
    download-dir = "/transmission/download";
    incomplete-dir = "/transmission/.incomplete";
    };
    };
  */

}
