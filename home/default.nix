{ pkgs, ... }:
{
  imports = [
    # Desktop
    ./i3
    ./picom.nix
    ./autorandr.nix
    ./xidlehook.nix

    ./feh-bg
    ./rofi.nix

    ./gtk.nix
    ./xdg.nix

    # Terminal
    ./alacritty
    ./bash.nix
    ./readline.nix

    # Editor
    ./vscode
    ./neovim

    # Other
    ./gpg
    ./git.nix
    ./firefox.nix
    ./user-dirs.nix
  ];


  home = {
    username = "toma";
    stateVersion = "22.11";
    sessionVariables = {
      DOTNET_CLI_TELEMETRY_OPTOUT = "true";
    };
    packages = with pkgs;
      [

        ### User stuff ###
        discord # Online Chat - UNFREE
        obsidian # Note-taking - UNFREE
        gimp # Image editing
        unstable.osu-lazer-bin # Rythm moment - UNFREE
        unstable.ani-cli # Anime moment

        unstable.mpv

        xfce.thunar

        ### Utils ###
        lxappearance # Look at themes (just don't switch them)
        gparted # Partition Management
        quark-goldleaf # Nintendo Switch File Transfer Client
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

        # NodeJS
        nodejs
        unstable.nodePackages_latest.pnpm # npm alternative

        # Dotnet - C#/F#
        dotnet-sdk

        # Python
        python311

        #APL
        dyalog-apl #UNFREE

      ];
  };
}
