{ pkgs, ... }: {
  programs.feh.enable = true;
  services.random-background = {
    enable = true;
    enableXinerama = true;
    display = "fill";
    imageDirectory = "${./wallpapers}";
    interval = "1h";
  };
}
