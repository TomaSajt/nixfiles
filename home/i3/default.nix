{ pkgs, config, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.unstable.i3;
    config = {
      modifier = "Mod4";
      terminal = "${config.programs.alacritty.package}/bin/alacritty";
      menu = "--no-startup-id \"${config.programs.rofi.package}/bin/rofi -show combi -combi-modes 'window,run,drun' -modes combi\"";
      floating = {
        criteria = [
          { class = "lxqt-openssh-askpass"; }
        ];
      };
      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        style = "Bold";
        size = 11.0;
      };
      gaps = {
        outer = 5;
        inner = 20;
        smartGaps = true;
      };
    };
  };

  services.picom.enable = true;
}
