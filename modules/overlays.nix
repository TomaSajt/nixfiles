{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (import ../overlay)
      ];
    };
}
