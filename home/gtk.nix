{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      # it says light, but it's actually dark
      name = "Catppuccin-Latte-Compact-Blue-Light";
      package = pkgs.unstable.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "compact";
        tweaks = [ "rimless" /*"black"*/ ];
        variant = "latte";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Latte-Dark-Cursors";
      package = pkgs.catppuccin-cursors.latteDark;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
