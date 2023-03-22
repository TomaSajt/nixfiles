# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    "${home-manager}/nixos"
  ];

  nixpkgs.overlays = [
    (self: super:
      {
        quark-goldleaf = super.callPackage ./custom/quark-goldleaf/default.nix { };
        nixos-grub-theme = super.callPackage ./custom/nixos-grub-theme/default.nix { };
        vimPlugins = super.vimPlugins // {
          mason-lspconfig-nvim = (import ./custom/mason-lspconfig-nvim/default.nix) { };
          mason-nvim = (import ./custom/mason-nvim/default.nix) { };
        };
      }
    )
  ];

  users.users.toma = {
    isNormalUser = true;
    description = "Toma";
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.toma = {
    # Required version field
    home.stateVersion = "22.11";

    home.username = "toma";

    programs.bash = {
      enable = true;
      initExtra = ''
        export EDITOR="nvim"
        alias snrs="sudo nixos-rebuild switch"
        alias ll="ls -la"
      '';
    };

    home.packages = with pkgs; [

      ### User stuff ###
      firefox # Browser
      discord # Online Chat
      libreoffice # Office Tools
      obsidian # Note-taking

      ### Utils ###
      gh # GitHub CLI
      gparted # Partition Management
      quark-goldleaf # Nintendo Switch File Transfer Client
      zip # Zip compression utils
      unzip

      ### Support ###
      ntfs3g # NTFS Filesystem Support
      ripgrep # telescope.nvim support for grep
      xclip # Clipboard support (for synced neovim clipboard)

      ### Languages ###
      gcc # C/C++
      ccls # C/C++ Language Server
      nodejs # NodeJS
      nodePackages.pnpm # Node Package Manager
      nodePackages.typescript-language-server # NodeJS Language Server
      dotnet-sdk # C#
      omnisharp-roslyn # C# Language Server
      jdk # Java
      rustup # Rust
      rust-analyzer # Rust Language Server
      python # Python
      nodePackages.pyright # Python Language Server
      rnix-lsp # Nix Language Server
      sumneko-lua-language-server # Lua Lanuage Server
    ];

    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
      };
      settings = import ./polybar/settings.nix;
      script = "polybar top &";
    };

    systemd.user.services.polybar = {
      Install.WantedBy = [ "graphical-session.target" ];
    };


    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "Toma";
      userEmail = "***REMOVED***";
      extraConfig = {
        github.user = "TomaSajt";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        credential.helper = "${pkgs.gitAndTools.gitFull}/bin/git-credential-libsecret";
      };
    };


    programs.neovim = {
      enable = true;
      defaultEditor = true; # Doesn't actually work, because home.sessionVariables is broken for some reason
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        plenary-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-file-browser-nvim
        nvim-treesitter
        nvim-web-devicons
        vim-monokai
        nvim-lspconfig
        nvim-cmp
        mason-lspconfig-nvim
        mason-nvim
      ];
      extraLuaConfig = builtins.readFile ./neovim/init.lua;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes) "experimental-features = nix-command flakes"; # This config is currently not using flakes (I think), so idk why I put this here
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };
  };

  services.udev.extraRules = ''
    # Nintendo Switch (for Goldleaf+Quark connection)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
  '';

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    # This doesn't seem to work :/
    grub = {
      theme = pkgs.nixos-grub-theme;
    };
    systemd-boot.enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Budapest";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings =
      let HU = "hu_HU.UTF-8";
      in
      {
        LC_ADDRESS = HU;
        LC_IDENTIFICATION = HU;
        LC_MEASUREMENT = HU;
        LC_MONETARY = HU;
        LC_NAME = HU;
        LC_NUMERIC = HU;
        LC_PAPER = HU;
        LC_TELEPHONE = HU;
        LC_TIME = HU;
      };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    layout = "hu";
    xkbVariant = "";

    # Enable touchpad support (with natural scrolling)
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };

  # For some reason, the default login prompt loads too quickly and display-manager can't start
  # This is fixed by waiting for some other services to load before starting
  systemd.services.display-manager = {
    wants = [ "systemd-user-sessions.service" "multi-user.target" "network-online.target" ];
    after = [ "systemd-user-sessions.service" "multi-user.target" "network-online.target" ];
  };

  # Configure console keymap
  console.keyMap = "hu101";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = [ ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
