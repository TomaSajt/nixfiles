{ pkgs, config, osConfig, ... }:
let
  mod = "Mod4";
  i3lock-fancy = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
  alacritty = "${config.programs.alacritty.package}/bin/alacritty";
  rofi = "${config.programs.rofi.finalPackage}/bin/rofi";
  amixer = "${pkgs.alsa-utils}/bin/amixer";
  playerctl = "${config.services.playerctld.package}/bin/playerctl";
  xbacklight = "${pkgs.acpilight}/bin/xbacklight";
in
{
  imports = [ ./status.nix ];

  services.network-manager-applet.enable = true;
  services.pasystray.enable = true;
  services.picom.enable = true;
  services.playerctld.enable = true;
  xsession.numlock.enable = true;
  xsession.enable = true;

  services.udiskie = {
    enable = true;
    tray = "always";
  };

  services.screen-locker = {
    enable = true;
    lockCmd = "${i3lock-fancy}";
    xss-lock = {
      screensaverCycle = 300;
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = osConfig.services.xserver.windowManager.i3.package;
    extraConfig = ''
      # this is required for gnome-keyring/libsecret/seahorse to work
      exec_always dbus-update-activation-environment --all
    '';
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
      keybindings = {
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

        "${mod}+mod2+KP_1" = "exec firefox";
        "${mod}+mod2+KP_2" = "exec --no-startup-id ${rofi} -show calc -modi calc -no-show-match -no-sort";

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
}
