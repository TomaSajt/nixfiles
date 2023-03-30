self: super:
{
  quark-goldleaf = super.callPackage ./quark-goldleaf { };
  vscode-extensions = super.vscode-extensions // import ./vscode-extensions super;
}
