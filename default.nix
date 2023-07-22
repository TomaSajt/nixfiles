{ inputs, pkgs, ... }:
{

  system.stateVersion = "22.11";

  imports = [
    ./debug-installed.nix
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
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  users.users.toma = {
    isNormalUser = true;
    description = "Toma";
    uid = 1000;
    extraGroups = [
      "networkmanager"
      "wheel"
      "transmission"
    ];
  };


  nix =
    let
      emptyRegisty = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    {
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
      # Enables experimental features and clears the registy to avoid most impurities
      extraOptions = ''
        experimental-features = nix-command flakes
        flake-registry = ${emptyRegisty}
        warn-dirty = false
      '';
      registry = {
        nixpkgs.to = lock.nodes.nixpkgs.locked;
        nixpkgs-unstable.to = lock.nodes.nixpkgs-unstable.locked;
      };
      gc = {
        automatic = true;
        randomizedDelaySec = "14m";
        options = "--delete-older-than 10d";
      };
    };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs;[
    git
    vim
    wget
    unzip
  ];

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.defaultSession = "none+i3";
    layout = "hu,apl";
    xkbVariant = "dyalog";
    xkbOptions = "grp:caps_switch";
  };
  console.useXkbConfig = true;

  # Secrets management or something
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Some config support or something
  programs.dconf.enable = true;

  # Some kind of accessibility thingy, makes a waring go away
  services.gnome.at-spi2-core.enable = true;

  # Needed for udiskie to work (in home-manager configs)
  services.udisks2.enable = true;

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

  services.udev = {
    #packages = with pkgs; [ unstable.quark-goldleaf ];
    extraRules = ''
      # Backlight permissions
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
  };



  # Locale stuff
  i18n =
    let
      HU = "hu_HU.UTF-8";
      EN = "en_US.UTF-8";
    in
    {
      defaultLocale = EN;
      extraLocaleSettings =
        {
          LC_NUMERIC = EN;
          LC_ADDRESS = HU;
          LC_IDENTIFICATION = HU;
          LC_MEASUREMENT = HU;
          LC_MONETARY = HU;
          LC_NAME = HU;
          LC_PAPER = HU;
          LC_TELEPHONE = HU;
          LC_TIME = HU;
        };
    };
  time = {
    timeZone = "Europe/Budapest";
    hardwareClockInLocalTime = true;
  };


  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };
}
