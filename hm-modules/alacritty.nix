{ pkgs, lib, config, ... }:

let
  cfg = config.modules.alacritty;
in
{
  options.modules.alacritty = {
    enable = lib.mkEnableOption "alacritty";
    font-size = lib.mkOption {
      type = lib.types.number;
      apply = toString;
      default = 10;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
    };

    xdg.configFile."alacritty/alacritty.yml".text = ''
      window:
        opacity: 0.8
        padding:
          x: 10
          y: 10
      font:
        normal:
          family: monospace
        size: ${cfg.font-size}
        builtin_box_drawing: true

      colors:
        # Default colors
        primary:
          background: '0x2D2A2E'
          foreground: '0xfff1f3'

        # Normal colors
        normal:
          black:   '0x2c2525'
          red:     '0xfd6883'
          green:   '0xadda78'
          yellow:  '0xf9cc6c'
          blue:    '0xf38d70'
          magenta: '0xa8a9eb'
          cyan:    '0x85dacc'
          white:   '0xfff1f3'

        # Bright colors
        bright:
          black:   '0x72696a'
          red:     '0xfd6883'
          green:   '0xadda78'
          yellow:  '0xf9cc6c'
          blue:    '0xf38d70'
          magenta: '0xa8a9eb'
          cyan:    '0x85dacc'
          white:   '0xfff1f3'
    '';
  };
}
