final: prev:
{
  quark-goldleaf = prev.callPackage ./quark-goldleaf { };
  vscode-extensions = prev.vscode-extensions // prev.callPackage ./vscode-extensions { };
}
