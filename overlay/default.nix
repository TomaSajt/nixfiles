self: super:
{
  quark-goldleaf = super.callPackage ./quark-goldleaf { inherit (super) pkgs; };
  nixos-grub-theme = super.callPackage ./nixos-grub-theme { inherit (super) pkgs; };
  vscode-extensions = super.vscode-extensions // {
    batisteo.vscode-django = super.callPackage ./vscode-extensions/batisteo.vscode-django { inherit (super) pkgs; };
    SPGoding.datapack-language-server = super.callPackage ./vscode-extensions/SPGoding.datapack-language-server { inherit (super) pkgs; };
    arcensoth.language-mcfunction = super.callPackage ./vscode-extensions/arcensoth.language-mcfunction { inherit (super) pkgs; };
  };
}
