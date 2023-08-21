{ pkgs, lib, config, osConfig, ... }:
let
  cfg = config.modules.i3;

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
  dbus-update-activation-environment = "${pkgs.dbus}/bin/dbus-update-activation-environment";


  i3status-rs = "${config.programs.i3status-rust.package}/bin/i3status-rs";
  i3status-rs-dir = "${config.xdg.configHome}/i3status-rust";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  nm-connection-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
in
{
  imports = [ ./xidlehook.nix ./autorandr.nix ];

  options.modules.i3 = {
    enable = lib.mkEnableOption "i3";
  };

  config = lib.mkIf cfg.enable {

    # For the player keys to properly work (maybe)
    services.playerctld.enable = true;

    xsession.enable = true;
    xsession.numlock.enable = true;

    programs.rofi = {
      enable = true;
      theme = "android_notification";
      plugins = [ pkgs.rofi-calc pkgs.rofimoji ];
    };

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
          "${mod}+mod2+KP_1" = "exec ${firefox} --profile ${firefox-dir}/main --new-window";
          "${mod}+mod2+KP_2" = "exec ${firefox} --profile ${firefox-dir}/school --new-window";
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

          "XF86MonBrightnessUp" = "exec --no-startup-id ${xbacklight} -inc 5";
          "XF86MonBrightnessDown" = "exec --no-startup-id ${xbacklight} -dec 5";
          "${mod}+XF86MonBrightnessUp" = "exec --no-startup-id ${xbacklight} -inc 1";
          "${mod}+XF86MonBrightnessDown" = "exec --no-startup-id ${xbacklight} -dec 1";

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
          outer = 0;
          inner = 5;
          smartGaps = true;
        };
        startup = [
          # this is required for gnome-keyring/libsecret/seahorse to work
          {
            command = "${dbus-update-activation-environment} --all";
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

        bars = [{
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${i3status-rs} ${i3status-rs-dir}/config-default.toml";
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
        }];
      };
    };
    programs.i3status-rust = {
      enable = true;
      package = pkgs.unstable.i3status-rust;
      bars.default = {
        icons = "awesome6";
        theme = "gruvbox-dark";
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            format = " $icon /: $available.eng(w:2) ";
            interval = 20;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents.eng(w:2) ";
            format_alt = " $icon $swap_used_percents.eng(w:2) ";
            interval = 1;
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            format = " $icon $1m ";
            interval = 1;
          }
          {
            block = "sound";
            format = " $icon $output_name {$volume.eng(w:2) |}";
            mappings = {
              "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
              "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink" = "";
            };
            click = [{
              button = "left";
              cmd = "${pavucontrol} --tab=3";
            }];
          }
          {
            block = "net";
            format = " $icon  {$signal_strength $ssid $frequency|Wired connection} - $device ";
            click = [{
              button = "left";
              cmd = "${nm-connection-editor}";
            }];
          }
          {
            block = "battery";
            format = "{ $icon  $percentage ($time) |}";
            interval = 5;
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %y.%m.%d %R') ";
            interval = 5;
          }
        ];
      };
    };
  };
}