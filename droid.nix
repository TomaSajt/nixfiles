{ pkgs, ... }:

{
  environment.packages = with pkgs; [
    nano
    neovim
    zip
    unzip
    man
    gnugrep
    gnused
    which
    hostname
  ];

  home-manager = {
    useGlobalPkgs = true;
    config = {
      imports = [ ./hm-modules/bash.nix ./hm-modules/git.nix ];
      modules = {
        bash.enable = true;
        git.enable = true;
      };
      home.stateVersion = "23.11";
    };
  };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "23.11";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Europe/Budapest";
}
