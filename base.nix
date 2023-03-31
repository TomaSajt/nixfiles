{ config, pkgs, lib, ... }:
{

  imports = [
    ./neovim
    ./polybar
    ./vscode
  ];


  users.users.toma = {
    isNormalUser = true;
    description = "Toma";
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" ];
  };


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.toma = { pkgs, ... }: {

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
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
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
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
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
