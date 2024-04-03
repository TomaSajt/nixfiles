{ pkgs, ... }:

{
  system.stateVersion = "23.11";

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
      home.stateVersion = "23.11";
      imports = [
        ./hm-modules/bash.nix
        ./hm-modules/git.nix
      ];
      modules = {
        bash.enable = true;
        git.enable = true;
      };
    };
  };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Europe/Budapest";
}
