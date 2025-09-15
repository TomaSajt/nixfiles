{
  flake.modules.homeManager.graphical = {
    modules.mime-apps.associations = {
      "image/jpeg" = "feh.desktop";
    };

    programs.feh = {
      enable = true;
    };
  };
}
