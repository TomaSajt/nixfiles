rec {
  colors = {
    background = "#282A2E";
    background-alt = "#373B41";
    foreground = "#C5C8C6";
    primary = "#F0C674";
    secondary = "#8ABEB7";
    alert = "#A54242";
    disabled = "#707880";
    transparent = "#00000000";
  };
  "bar/top" = {
    width = "100%";
    height = "24pt";
    radius = 6;

    background = colors.background;
    foreground = colors.foreground;

    line-size = "4pt";

    border = {
      size = "4pt";
      color = colors.transparent;
    };

    padding = {
      left = 0;
      right = 1;
    };

    module-margin = 1;

    separator = "|";
    separator-foreground = colors.disabled;

    font = [ "Monospace:style=Regular:size=10;2" ];

    modules = {
      left = "xworkspaces xwindow i3";
      right = "battery filesystem pulseaudio xkeyboard memory cpu wlan eth date";
    };

    tray-position = "right";

    cursor = {
      click = "pointer";
      scroll = "ns-resize";
    };

    enable-ipc = true;
  };

  "module/xworkspaces" = {
    type = "internal/xworkspaces";
    label = {
      active = "%name%";
      active-background = colors.background-alt;
      active-underline = colors.primary;
      active-padding = 1;

      occupied = "%name%";
      occupied-padding = 1;

      urgent = "%name%";
      urgent-background = colors.alert;
      urgent-padding = 1;

      empty = "%name%";
      empty-background = colors.disabled;
      empty-padding = 1;
    };
  };

  "module/i3" = {
    type = "internal/i3";

    strip-wsnumbers = false;

    index-sort = false;

    enable-click = true;

    enable-scroll = true;

    wrapping-scroll = true;

    reverse-scroll = false;

    fuzzy-match = true;

    ws-icon-default = "WS";

    format = "<label-state> <label-mode>";

    format-padding = 1;

    label-separator = "|";
    label-separator-padding = 2;
    label-separator-foreground = "#ffb52a";
  };

  "module/battery" = {
    type = "internal/battery";
    full-at = 100;
    low-at = 10;
    battery = "BAT0";
    poll-interval = 5;

    time-format = "%-Hh %-Mm";
    format = {
      charging = "<animation-charging> <label-charging>";
      discharging = "<ramp-capacity> <label-discharging>";
    };

    label = {
      charging = "%percentage%% (%time%)";
      discharging = "%percentage%% (%time%)";
      full = "Fully charged";
      low = "BATTERY LOW %percentage%%";
    };

    ramp-capacity = [ " " " " " " " " " " ];

    animation-charging = [ " " " " " " " " " " ];
    animation-charging-framerate = 750;
  };

  "module/xwindow" = {
    type = "internal/xwindow";
    label = "%title:0:60:...%";
  };

  "module/filesystem" = {
    type = "internal/fs";
    interval = 25;
    mount = [ "/" ];
    label = {
      mounted = "%{F${colors.primary}}%mountpoint%%{F-} %percentage_used%%";
      unmounted = "%mountpoint% not mounted";
      unmounted-foreground = colors.disabled;
    };
  };

  "module/pulseaudio" = {
    type = "internal/pulseaudio";
    format = {
      volume-prefix = "VOL ";
      volume-prefix-foreground = colors.primary;
      volume = "<label-volume>";
    };
  };

  "module/xkeyboard" = {
    type = "internal/xkeyboard";
    blacklist = [ "num lock" ];
    label = {
      layout = "%layout%";
      layout-foreground = colors.primary;
      indicator = {
        padding = 2;
        margin = 1;
        foreground = colors.background;
        background = colors.secondary;
      };
    };
  };

  "module/memory" = {
    type = "internal/memory";
    interval = 2;
    format = {
      prefix = "RAM ";
      prefix-foreground = colors.primary;
    };
    label = "%percentage_used:2%%";
  };

  "module/cpu" = {
    type = "internal/cpu";
    interval = 2;
    format = {
      prefix = "CPU ";
      prefix-foreground = colors.primary;
    };
    label = "%percentage:2%%";
  };

  network-base = {
    type = "internal/network";
    interval = 5;
    format = {
      connected = "<label-connected>";
      disconnected = "<label-disconnected>";
    };
    label.disconnected = "%{F${colors.primary}}%ifname%%{F#707880} disconnected";
  };

  "module/wlan" = {
    "inherit" = "network-base";
    interface-type = "wireless";
    label.connected = "%{F${colors.primary}}%ifname%%{F-} %essid% %local_ip%";
  };

  "module/eth" = {
    "inherit" = "network-base";
    interface-type = "wired";
    label.connected = "%{F${colors.primary}}%ifname%%{F-} %local_ip%";
  };


  "module/date" = {
    type = "internal/date";
    interval = 1;

    date = "%H:%M";
    date-alt = "%Y.%m.%d %H:%M:%S";
    label = "%date%";
    label-foreground = colors.primary;
  };
  settings = {
    screenchange-reload = true;
    pseudo-transparency = true;
  };
}
