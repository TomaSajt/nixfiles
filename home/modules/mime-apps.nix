{ lib, config, ... }:

with lib;

let
  cfg = config.modules.mime-apps;
  # check /etc/profiles/per-user/toma/share/applications/mimeinfo.cache for associations used by the system already
  associations = {
    "application/pdf" = [ "firefox.desktop" ];
    "image/jpeg" = [ "feh.desktop" ];
    "inode/directory" = [ "thunar.desktop" ];
  };
in
{
  options.modules.mime-apps = {
    enable = mkEnableOption "mime-apps";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
