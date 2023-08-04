{ pkgs, lib, ... }:
{
  imports = [
    ./modules

    # Desktop
    ./autorandr.nix

    ./feh-bg

    # Editor
    ./vscode
    ./neovim

    # Other
    ./user-dirs.nix
  ];

  modules = lib.mkDefault {
    gpg.enable = true;
    git = {
      enable = true;
      signing = true;
    };
    dotnet.enable = true;
    bash.enable = true;
    i3 = {
      enable = true;
      xidlehook.enable = true;
    };
    alacritty = {
      enable = true;
      font-size = 10.0;
    };
    firefox.enable = true;
    dyalog.enable = true;
    mime-apps.enable = true;
    gtk.enable = true;
    picom = {
      enable = true;
      vSync = true;
    };
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
      gimp # Image editing
      unstable.osu-lazer-bin # Rythm moment - UNFREE
      unstable.ani-cli # Anime moment
      mpv # Video player
      xfce.thunar # File manager
      prismlauncher # Minecraft Launcher

      ### Utils ###
      lxappearance # Look at themes (just don't switch them)
      gparted # Partition Management
      # quark-goldleaf # Nintendo Switch File Transfer Client
      zip # Zip compression utils
      unzip
      wget
      file
      qdirstat

      ### Support ###
      ntfs3g # NTFS Filesystem Support
      ripgrep # telescope.nvim support for grep
      xclip # Clipboard support (for synced neovim clipboard)
      fd # `find` alternative (used for neovim)

      ### Languages ###

      # C++
      gcc

      # Java
      jdk

      # NodeJS
      nodejs
      nodePackages_latest.pnpm # npm alternative

      # Python
      python311
    ];
  };
}
