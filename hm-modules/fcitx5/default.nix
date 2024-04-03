{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.fcitx5;
in
{
  options.modules.fcitx5 = {
    enable = lib.mkEnableOption "fcitx5";
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };

    xdg.configFile."fcitx5/config".source = ./config;
    xdg.configFile."fcitx5/profile".source = ./profile;
    xdg.configFile."fcitx5/profile".force = true;

    home.sessionVariables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
    };
  };
}
