{ ... }: {
  imports = [
    ./i3

    ./git.nix
    ./gpg.nix
    ./dotnet.nix
    ./bash.nix
  ];
}
