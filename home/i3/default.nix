{ pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.unstable.i3;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "--no-startup-id rofi -show drun";
    };
    extraConfig = ''
      for_window [class="lxqt-openssh-askpass"] floating enable
    '';

  };
}
