self: super:
{
  quark-goldleaf = super.callPackage ./quark-goldleaf/default.nix { };
  nixos-grub-theme = super.callPackage ./nixos-grub-theme/default.nix { };
  vimPlugins = super.vimPlugins // {
    mason-lspconfig-nvim = (import ./mason-lspconfig-nvim/default.nix) { };
    mason-nvim = (import ./mason-nvim/default.nix) { };
  };
}
