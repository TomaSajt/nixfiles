{ config, ... }: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/images";
    videos = "${config.home.homeDirectory}/videos";
    desktop = null;
    music = null;
    publicShare = null;
    templates = null;
  };
}
