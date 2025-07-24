{ inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    ./graphical.nix
  ];

  home-manager.users.toma = import ./home.nix;

  programs.nix-index = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

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
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
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

  console.keyMap = "hu";

  # Locale stuff
  i18n =
    let
      HU = "hu_HU.UTF-8";
      EN = "en_US.UTF-8";
    in
    {
      defaultLocale = EN;
      extraLocaleSettings = {
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
}
