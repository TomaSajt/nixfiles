{ pkgs, ... }:
{
  imports = [
    ./vscode
    ./neovim
    ./polybar
  ];

  home = {
    username = "toma";
    packages = with pkgs; [

      ### User stuff ###
      firefox # Browser
      discord # Online Chat - UNSAFE
      obsidian # Note-taking - UNSAFE
      gimp # Image editing


      jetbrains.rider
      jetbrains.idea-community

      ### Utils ###
      gh # GitHub CLI
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
      dconf # Fixed some warinings when I was trying out Unity. idk if this is really needed

      jetbrains-mono-nerdfont


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
    stateVersion = "22.11";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      snrs = "sudo nixos-rebuild switch";
      ll = "ls -la";
      code = "codium";
    };
  };


  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Toma";
    userEmail = "62384384+TomaSajt@users.noreply.github.com";
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      last = "log -1 HEAD";
      uncommit = "reset --soft HEAD~";
    };
    extraConfig = {
      github.user = "TomaSajt";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
      pull.ff = "only";
    };

  };

  programs.yt-dlp = {
    enable = true;
  };
}
