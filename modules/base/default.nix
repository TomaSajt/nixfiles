{ inputs, ... }:
{

  flake.modules.nixos.base =
    { pkgs, ... }:

    {
      system.stateVersion = "23.11";

      users.users.toma = {
        isNormalUser = true;
        description = "Toma";
        uid = 1000;
        extraGroups = [
          "networkmanager"
          "wheel"
          "transmission"
          "docker"
          "plugdev"
          "input"
          "terraria"
        ];
      };

      fonts = {
        fontDir.enable = true;
        fontconfig.defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
          monospace = [
            "JetBrainsMono Nerd Font"
            "Uiua386"
          ];
        };
        packages = with pkgs; [
          noto-fonts
          noto-fonts-color-emoji
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          nerd-fonts.jetbrains-mono
          uiua386
        ];
      };

      nix =
        let
          emptyRegisty = builtins.toFile "empty-flake-registry.json" ''{"flakes":[], "version":2}'';
          lock = builtins.fromJSON (builtins.readFile ../../flake.lock);
        in
        {
          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];
            substituters = [ "https://nix-community.cachix.org" ];
            trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
            flake-registry = emptyRegisty;
            auto-optimise-store = false;
            warn-dirty = false;
            log-lines = 33;
          };
          # Hack ----> Profit
          registry = {
            nixpkgs.to = lock.nodes.nixpkgs.locked;
          };
          # point <nixpkgs> to our flake's path
          channel.enable = false;
          nixPath = [ "nixpkgs=flake:${inputs.nixpkgs}" ];
        };

      # List packages installed in system profile.
      environment.systemPackages = with pkgs; [
        git
        vim
        wget
        zip
        unzip
        file
        rsync
      ];

    };

  flake.modules.homeManager.base =
    { pkgs, lib, ... }:
    {
      imports = [
        ../../hm-modules
      ];

      modules = {
        neovim.enable = lib.mkDefault true;
        gpg.enable = lib.mkDefault true;
        langs = {
          cpp.enable = lib.mkDefault true;
          dotnet.enable = lib.mkDefault true;
          #dyalog.enable = lib.mkDefault true;
          javascript.enable = lib.mkDefault true;
          python.enable = lib.mkDefault true;
          rust.enable = lib.mkDefault true;
          uiua.enable = lib.mkDefault true;
        };
      };

      # Automatic external disk mounting to /var/run/mount
      services.udiskie = {
        enable = true;
        tray = "auto";
      };

      home = {
        username = "toma";
        stateVersion = "23.11";
        packages = with pkgs; [
          ntfs3g # NTFS Filesystem Support
          ripgrep # grep in filesystem (also used for telescope.nvim support for grep)
          # Clipboard utils (used for synced neovim clipboard)
          xclip
          wl-clipboard
          fd # `find` alternative (also used for neovim)
          killall
        ];
      };
    };
}
