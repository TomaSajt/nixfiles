{ pkgs, ... }: {
  home = {
    username = "toma";
    packages = with pkgs; [

      ### User stuff ###
      firefox # Browser
      chromium
      discord # Online Chat - UNSAFE
      libreoffice # Office Tools
      obsidian # Note-taking - UNSAFE


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


      ### Languages ###

      # C/C++
      gcc
      ccls

      # NodeJS
      nodejs
      nodePackages.pnpm # npm alternative
      nodePackages.typescript-language-server

      # Dotnet - C#/F#
      dotnet-sdk
      omnisharp-roslyn # Language Server

      # Java
      jdk

      # Rust
      rustup
      rust-analyzer

      # Python
      python311
      nodePackages.pyright

      # Lua
      lua
      (pkgs.unstable.lua-language-server)

      # Nix
      rnix-lsp


      # Svelte
      nodePackages.svelte-language-server
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
    initExtra = ''
      export EDITOR="nvim"
    '';
  };


  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Toma";
    userEmail = "62384384+TomaSajt@users.noreply.github.com";
    extraConfig = {
      github.user = "TomaSajt";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "${pkgs.gitAndTools.gitFull}/bin/git-credential-libsecret";
      pull.ff = "only";
    };
  };
}
