{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        # note: directories are capitalized by default, but I like them lower-case
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        pictures = "${config.home.homeDirectory}/images";
        desktop = "${config.home.homeDirectory}/desktop";
        videos = "${config.home.homeDirectory}/videos";
        music = null;
        publicShare = null;
        templates = null;
      };
    };
}
