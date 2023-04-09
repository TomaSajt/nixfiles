{ inputs, pkgs, ... }:
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

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
        flake-registry = ${emptyRegisty};
      '';
    # adds the system's current nixpkgs to the registry so that you can
    # run for example `nix run nixpkgs#firefox` without reinstalling
    registry.nixpkgs.flake = inputs.nixpkgs;
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 3d";
    };
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

  # Enable networking
  networking.networkmanager.enable = true;

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

  services.xserver = {

    enable = true;

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

  # For some reason, the default login prompt loads too quickly
  # and display-manager doesn't start (???)
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
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    unzip
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.11";
}
