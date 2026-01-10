{
  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        thunar
        tumbler # For thumbnails
      ];
      modules.mime-apps.associations = {
        "inode/directory" = "thunar.desktop";
      };
    };
}
