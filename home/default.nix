{ pkgs, ... }:
{
  imports = [
    # Desktop
    ./i3
    ./rofi
    ./gtk
    ./feh-bg

    ./user-dirs.nix

    # Terminal
    ./alacritty
    ./bash

    # Editor
    ./vscode
    ./neovim

    # Other
    ./git
    ./gpg
    ./firefox
  ];


  home = {
    username = "toma";
    stateVersion = "22.11";
    packages = with pkgs; [

      ### User stuff ###
      discord # Online Chat - UNSAFE
      obsidian # Note-taking - UNSAFE
      gimp # Image editing

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
      nodePackages.typescript-language-server

      # Dotnet - C#/F#
      dotnet-sdk
      omnisharp-roslyn # Language Server

      # Python
      python311
      nodePackages.pyright

      # Lua
      lua
      (pkgs.unstable.lua-language-server)

      # Nix
      rnix-lsp
    ];
  };
}
