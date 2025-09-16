{
  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord
        obsidian
        element-desktop

        ani-cli
        mpv

        gparted

        gimp
        inkscape

        nix-tree
        nix-du
        graphviz

        btop

        xdg-utils

        nix-update
        nixpkgs-review
      ];
    };

  nixpkgs.allowedUnfreePackages = [
    "discord"
    "obsidian"
  ];
}
