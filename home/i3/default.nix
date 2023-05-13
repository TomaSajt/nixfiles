{ pkgs, config, osConfig, ... }:
let
  mod = "Mod4";
  alacritty = "${config.programs.alacritty.package}/bin/alacritty";
  rofi = "${config.programs.rofi.finalPackage}/bin/rofi";
  rofimoji = "${pkgs.rofimoji}/bin/rofimoji";
  firefox = "${config.programs.firefox.package}/bin/firefox";
  firefox-dir = "${config.home.homeDirectory}/.mozilla/firefox";
  playerctl = "${config.services.playerctld.package}/bin/playerctl";
  xbacklight = "${pkgs.acpilight}/bin/xbacklight";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  gnome-screenshot = "${pkgs.gnome.gnome-screenshot}/bin/gnome-screenshot";
in
{
  imports = [ ./extras.nix ./bars.nix ];

  xsession.enable = true;
  xsession.numlock.enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    package = osConfig.services.xserver.windowManager.i3.package;
    config = {
      modifier = mod;
      keybindings = {
        "${mod}+Return" = "exec --no-startup-id ${alacritty}";
        "${mod}+Shift+q" = "kill";

        "${mod}+d" = "exec --no-startup-id \"${rofi} -show combi -combi-modes 'window,run,drun' -modes combi\"";
        "${mod}+period" = "exec --no-startup-id ${rofimoji}";

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
        "${mod}+Shift+a" = "focus child";

        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        "${mod}+Tab" = "workspace next";
        "${mod}+Shift+Tab" = "workspace prev";

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

        # mod2+KP_N are the numpad keys
        "${mod}+mod2+KP_1" = "exec ${firefox} --profile ${firefox-dir}/main";
        "${mod}+mod2+KP_2" = "exec ${firefox} --profile ${firefox-dir}/school";
        "${mod}+mod2+KP_3" = "exec --no-startup-id ${rofi} -show calc -modi calc -no-show-match -no-sort";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "${mod}+r" = "mode resize";

        "XF86AudioMute" = "exec --no-startup-id ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
        "${mod}+XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ +1%";
        "${mod}+XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume @DEFAULT_SINK@ -1%";

        "XF86AudioPlay" = "exec --no-startup-id ${playerctl} play";

        "XF86AudioStop" = "exec --no-startup-id ${playerctl} pause";
        "XF86AudioPause" = "exec --no-startup-id ${playerctl} play-pause";
        "XF86AudioNext" = "exec --no-startup-id ${playerctl} next";
        "XF86AudioPrev" = "exec --no-startup-id ${playerctl} previous";

        "XF86MonBrightnessUp" = "exec --no-startup-id ${xbacklight} -inc 10";
        "XF86MonBrightnessDown" = "exec --no-startup-id ${xbacklight} -dec 10";

        "${mod}+Print" = "exec ${gnome-screenshot} -i";

      };
      modes = {
        resize = {
          "${mod}+r" = "mode default";
          "Escape" = "mode default";
          "Return" = "mode default";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
        };
      };
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
      startup = [
        # this is required for gnome-keyring/libsecret/seahorse to work
        {
          command = "dbus-update-activation-environment --all";
          always = true;
          notification = false;
        }
      ];
      focus.followMouse = false;
      floating = {
        criteria = [
          { title = "Steam - Update News"; }
          { class = "Pavucontrol"; }
        ];
      };
      window.commands = [{
        command = "resize set 500 500";
        criteria = { class = "Pavucontrol"; };
      }];
    };
  };
}
