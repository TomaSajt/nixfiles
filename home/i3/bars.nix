{ pkgs, config, ... }:
let
  i3status-rs = "${config.programs.i3status-rust.package}/bin/i3status-rs";
  i3status-rs-dir = "${config.xdg.configHome}/i3status-rust";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  nm-connection-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
in
{
  xsession.windowManager.i3.config.bars = [
    {
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
    }
  ];


  programs.i3status-rust = {
    enable = true;
    package = pkgs.unstable.i3status-rust;

    bars = {
      default = {
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
            click = [
              {
                button = "left";
                cmd = "${pavucontrol} --tab=3";
              }
            ];
          }
          {
            block = "net";
            format = " $icon  {$signal_strength $ssid $frequency|Wired connection} - $device ";
            click = [
              {
                button = "left";
                cmd = "${nm-connection-editor}";
              }
            ];
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
        icons = "awesome6";
        theme = "gruvbox-dark";
      };
    };
  };
}
