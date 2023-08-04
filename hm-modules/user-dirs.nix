{ lib, config, ... }:
let
  cfg = config.modules.user-dirs;
in
{
  options.modules.user-dirs = {
    enable = lib.mkEnableOption "XDG User Dirs";
  };

  config = lib.mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/images";
      desktop = "${config.home.homeDirectory}/desktop";
      videos = null;
      music = null;
      publicShare = null;
      templates = null;
    };
  };
}
