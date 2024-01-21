{ pkgs, lib, ... }:
{
  imports = [ ./hm-modules ./utils ];

  modules = lib.mkDefault {
    alacritty = {
      enable = true;
      font-size = 10.0;
    };
    bash.enable = true;
    code-editors = {
      neovim.enable = true;
      vscode = {
        enable = true;
        codium = true;
      };
    };
    feh.enable = true;
    firefox.enable = true;
    games = {
      heroic.enable = true;
      minecraft.enable = true;
      osu.enable = true;
      steam.enable = true;
      wine.enable = true;
    };
    git = {
      enable = true;
      signing = true;
    };
    gpg.enable = true;
    gtk.enable = true;
    i3 = {
      enable = true;
      show-battery = true;
      xidlehook.enable = true;
      autorandr.enable = true;
    };
    langs = {
      cpp.enable = true;
      dotnet.enable = true;
      dyalog.enable = true;
      javascript.enable = true;
      python.enable = true;
      uiua.enable = true;
    };
    mime-apps.enable = true;
    notification = {
      enable = true;
      battery = true;
    };
    obs-studio.enable = true;
    picom = {
      enable = true;
      vSync = true;
    };
    thunar.enable = true;
    user-dirs.enable = true;
    wallpaper.enable = true;
  };

  # Network Applet
  services.network-manager-applet.enable = true;

  # Audio Applet
  services.pasystray.enable = true;

  # Automatic external disk mounting to /var/run/mount
  services.udiskie = {
    enable = true;
    tray = "auto";
  };

  home = {
    username = "toma";
    stateVersion = "23.11";
    packages = with pkgs; [
      ### User stuff ###
      discord # Online Chat - UNFREE
      dev1.obsidian # Note-taking - UNFREE
      element-desktop

      ani-cli
      mpv

      ### Utils ###
      gparted
      dev2.quark-goldleaf

      gimp
      inkscape
      jasp-desktop
      libsForQt5.filelight

      ### Support ###
      ntfs3g # NTFS Filesystem Support
      ripgrep # grep in filesystem (also used for telescope.nvim support for grep)
      xclip # Clipboard utils (used for synced neovim clipboard)
      fd # `find` alternative (also used for neovim)
    ];
  };
}
