{ pkgs, config, ... }: {

  imports = [ ./status.nix ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.unstable.i3;
    config = {
      fonts = {
        names = [ "monospace" ];
        style = "Bold";
        size = 11.0;
      };
      gaps = {
        outer = 5;
        inner = 20;
        smartGaps = true;
      };
      keybindings =
        let
          mod = "Mod4";
          alacritty = "${config.programs.alacritty.package}/bin/alacritty";
          rofi = "${config.programs.rofi.package}/bin/rofi";
          amixer = "amixer";
          playerctl = "${config.services.playerctld.package}/bin/playerctl";
          xbacklight = "${pkgs.acpilight}/bin/xbacklight";
        in
        {
          "${mod}+Return" = "exec ${alacritty}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec --no-startup-id \"${rofi} -show combi -combi-modes 'window,run,drun' -modes combi\"";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+f" = "fullscreen toggle";

          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+a" = "focus parent";

          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";

          "${mod}+0" = "workspace number 0";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";

          "${mod}+Shift+0" = "move container to workspace number 0";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

          "${mod}+r" = "mode resize";

          "XF86AudioMute" = "exec ${amixer} sset Master toggle";
          "XF86AudioRaiseVolume" = "exec ${amixer} sset Master 5%+";
          "XF86AudioLowerVolume" = "exec ${amixer} sset Master 5%-";
          "${mod}+XF86AudioRaiseVolume" = "exec ${amixer} sset Master 1%+";
          "${mod}+XF86AudioLowerVolume" = "exec ${amixer} sset Master 1%-";

          "XF86AudioPlay" = "exec ${playerctl} play";
          "XF86AudioStop" = "exec ${playerctl} pause";
          "XF86AudioPause" = "exec ${playerctl} play-pause";
          "XF86AudioNext" = "exec ${playerctl} next";
          "XF86AudioPrev" = "exec ${playerctl} previous";

          "XF86MonBrightnessUp" = "exec ${xbacklight} -inc 10";
          "XF86MonBrightnessDown" = "exec ${xbacklight} -dec 10";
        };
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
          fonts = {
            names = [ "monospace" ];
            size = 11.0;
          };
          trayOutput = "primary";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];
      floating = {
        criteria = [
          { class = "Pavucontrol"; }
        ];
      };
      window = {
        commands = [
          {
            command = "resize set 500 500";
            criteria = {
              class = "Pavucontrol";
            };
          }
        ];
      };

    };
  };
  services.network-manager-applet.enable = true;
  services.picom.enable = true;
  services.playerctld.enable = true;
}
