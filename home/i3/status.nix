{ pkgs, ... }: {
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
            format = " $icon $output_name $volume.eng(w:2) ";
            mappings = {
              "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            };
            click = [
              {
                button = "left";
                cmd = "${pkgs.pavucontrol}/bin/pavucontrol --tab=3";
              }
            ];
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %y.%m.%d %R') ";
            interval = 5;
          }
        ];
        icons = "awesome5";
        theme = "gruvbox-dark";
      };
    };
  };
}
