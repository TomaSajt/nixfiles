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
    packages = with pkgs; [

      ### User stuff ###
      discord # Online Chat - UNSAFE
      obsidian # Note-taking - UNSAFE
      gimp # Image editing
      unstable.ani-cli

      ### Utils ###
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

      ### Languages ###

      # NodeJS
      nodejs
      nodePackages.pnpm # npm alternative

      # Dotnet - C#/F#
      dotnet-sdk
      omnisharp-roslyn # Language Server

      # Python
      python311

      # Lua
      lua

      # Nix
    ];
  };
}
