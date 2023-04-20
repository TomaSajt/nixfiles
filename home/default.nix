{ pkgs, ... }:
{
  imports = [
    # Desktop
    ./i3
    ./xidlehook.nix
    ./feh-bg
    ./rofi.nix

    ./autorandr.nix

    ./user-dirs.nix
    ./gtk.nix

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
        unstable.osu-lazer # Rythm moment - UNFREE
        unstable.ani-cli # Anime moment

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
        nodePackages.pnpm # npm alternative

        # Dotnet - C#/F#
        unstable.dotnet-sdk

        # Python
        python311

      ];
  };
}
