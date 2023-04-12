{ pkgs, ... }:
{
  xdg.configFile."alacritty".source = ./config;
  programs.alacritty = {
    enable = true;
  };
}
