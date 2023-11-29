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
    dotnet.enable = true;
    dyalog.enable = true;
    feh.enable = true;
    firefox.enable = true;
    games = {
      heroic.enable = false; # electron EOL stuff
      steam.enable = true;
      wine.enable = true;
      osu.enable = true;
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
    stateVersion = "22.11";
    packages = with pkgs; [
      ### User stuff ###
      discord # Online Chat - UNFREE
      obsidian # Note-taking - UNFREE
      gimp
      ani-cli
      mpv
      prismlauncher

      ### Utils ###
      gparted
      dev3.quark-goldleaf
      zip
      unzip
      wget
      file
      gdb

      inkscape

      ### Support ###
      ntfs3g # NTFS Filesystem Support
      ripgrep # telescope.nvim support for grep
      xclip # Clipboard support (for synced neovim clipboard)
      fd # `find` alternative (used for neovim)

      ### Languages ###
      gcc
      nodejs
      nodejs.pkgs.pnpm
      python311
      dev-uiua.uiua
    ];
  };
}
