{ inputs, pkgs, ... }:

{
  system.stateVersion = "23.11";

  fonts = {
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "JetBrainsMono Nerd Font" "Uiua386" ];
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      uiua386
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
      "docker"
      "plugdev"
      "input"
    ];
  };

  nix =
    let
      emptyRegisty = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    {
      settings = {
        experimental-features = [ "nix-command" "flakes" ]; # How did I survive without these?
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
        auto-optimise-store = true;
        warn-dirty = false;
        flake-registry = emptyRegisty;
      };
      # Hack ----> Profit
      registry = {
        nixpkgs.to = lock.nodes.nixpkgs.locked;
      };
      # Now way, legacy support
      channel.enable = true;
      nixPath = [ "nixpkgs=flake:${inputs.nixpkgs}" ];
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

  virtualisation.docker.enable = true;

  security.polkit = {
    enable = true;
    debug = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.udev = {
    packages = with pkgs; [ dev2.quark-goldleaf ];
    extraRules = ''
      # Backlight permissions
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"

      KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
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
