{ pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.unstable.i3;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
    };
  };
}
