{ ... }: {
  imports = [
    ./i3

    ./git.nix
    ./gpg.nix
    ./dotnet.nix
    ./bash.nix
    ./alacritty.nix
    ./firefox.nix
    ./dyalog.nix
    ./mime-apps.nix
    ./gtk.nix
    ./picom.nix
  ];
}
