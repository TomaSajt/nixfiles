{ pkgs, inputs, ... }:
let
  dotnet-sdks = with pkgs.unstable.dotnetCorePackages; combinePackages [
    sdk_6_0
    sdk_7_0
  ];
  inherit (inputs.dyalog-nixos.packages.${pkgs.system}) dyalog ride;
in

{
  imports = [
    ./modules
    # Desktop
    ./picom.nix
    ./autorandr.nix
    ./xidlehook.nix

    ./feh-bg
    ./rofi.nix

    ./gtk.nix
    ./xdg.nix

    # Terminal
    ./alacritty
    ./readline.nix

    # Editor
    ./vscode
    ./neovim

    # Other
    ./firefox.nix
    ./user-dirs.nix
  ];

  modules = {
    gpg = {
      enable = true;
    };
    git = {
      enable = true;
      signing = true;
    };
    dotnet = {
      enable = true;
    };
    bash = {
      enable = true;
    };
    i3 = {
      enable = true;
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

      # APL
      dyalog
      ride # Editor
    ];
  };
}
