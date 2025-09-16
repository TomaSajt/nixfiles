{
  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs.xfce; [
        thunar
        tumbler # For thumbnails
      ];
      modules.mime-apps.associations = {
        "inode/directory" = "thunar.desktop";
      };
    };
}
