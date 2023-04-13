{ inputs, pkgs, ... }:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  fonts = {
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
    fonts = with pkgs; [
      noto-fonts
      jetbrains-mono-nerdfont
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.toma.imports = [ ./home ];
  };

  users.users.toma = {
    isNormalUser = true;
    description = "Toma";
    uid = 1000;
    extraGroups = [ "networkmanager" "wheel" "transmission" ];
  };

  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true;
    };
    # Enables flakes
    package = pkgs.nixFlakes;
    extraOptions =
      let
        emptyRegisty = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      in
      # Enables experimental features and clears the registy to avoid most impurities
      ''
        experimental-features = nix-command flakes
        flake-registry = ${emptyRegisty}
      '';
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 3d";
    };
  };

  # Secrets management or something
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Some config support or something
  programs.dconf.enable = true;

  # Configure console keymap
  console.keyMap = "hu101";

  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.unstable.i3;
    };
    displayManager.defaultSession = "none+i3";
    layout = "hu";
    xkbVariant = "";
    # Enable touchpad support (with natural scrolling)
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };




  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    unzip
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.udev.extraRules = ''
    # Nintendo Switch (for Goldleaf+Quark connection)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
  '';

  # Bootloader
  boot.loader = {
    grub = {
      theme = pkgs.nixos-grub2-theme;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    systemd-boot.enable = true;
  };

  time = {
    timeZone = "Europe/Budapest";
    # For Windows and Linux to have synced time
    hardwareClockInLocalTime = true;
  };

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

  system.stateVersion = "22.11";
}
