self: super:
{
  quark-goldleaf = super.callPackage ./quark-goldleaf/default.nix { inherit (super) pkgs; };
  nixos-grub-theme = super.callPackage ./nixos-grub-theme/default.nix { inherit (super) pkgs; };
  vscode-extensions = super.vscode-extensions // {
    batisteo.vscode-django = super.callPackage ./vscode-extensions/batisteo.vscode-django/default.nix { inherit (super) pkgs; };
    SPGoding.datapack-language-server = super.callPackage ./vscode-extensions/SPGoding.datapack-language-server/default.nix { inherit (super) pkgs; };
    arcensoth.language-mcfunction = super.callPackage ./vscode-extensions/arcensoth.language-mcfunction/default.nix { inherit (super) pkgs; };
  };
}
