{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    theme = "android_notification";
    plugins = with pkgs; [ rofi-calc ];
  };
}
