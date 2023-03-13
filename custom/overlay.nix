{ ... } :
{
  nixpkgs.overlays = [
    (
      self: super:
      {
        quark-goldleaf = super.callPackage ./quark-goldleaf/default.nix {};
      }
    )
  ];
}
