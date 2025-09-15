{
  flake.modules.homeManager.fcitx5 =
    {
      pkgs,
      ...
    }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
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
