{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.alacritty;
in
{
  options.modules.alacritty = {
    enable = lib.mkEnableOption "alacritty";
    font-size = lib.mkOption {
      type = lib.types.number;
      default = 10;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };
    xdg.configFile."alacritty/alacritty.toml".source = pkgs.writers.writeTOML "alacritty.toml" {
      colors = {
        bright = {
          black = "0x72696a";
          blue = "0xf38d70";
          cyan = "0x85dacc";
          green = "0xadda78";
          magenta = "0xa8a9eb";
          red = "0xfd6883";
          white = "0xfff1f3";
          yellow = "0xf9cc6c";
        };
        normal = {
          black = "0x2c2525";
          blue = "0xf38d70";
          cyan = "0x85dacc";
          green = "0xadda78";
          magenta = "0xa8a9eb";
          red = "0xfd6883";
          white = "0xfff1f3";
          yellow = "0xf9cc6c";
        };
        primary = {
          background = "0x2D2A2E";
          foreground = "0xfff1f3";
        };
      };

      font = {
        builtin_box_drawing = true;
        size = cfg.font-size;
        normal = {
          family = "monospace";
        };
      };
      window = {
        opacity = 0.8;
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}
