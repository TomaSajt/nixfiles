{ ... }:
{
  nixpkgs.overlays = [
    (
      self: super:
      {
        quark-goldleaf = super.callPackage ./quark-goldleaf/default.nix {};
        nixos-grub-theme = super.callPackage ./nixos-grub-theme/default.nix {};
      }
    )
  ];
}
