{ pkgs, ... }:
{
  services.xidlehook = {
    enable = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    timers = [
      {
        delay = 300;
        command = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
      }
    ];
  };
}
