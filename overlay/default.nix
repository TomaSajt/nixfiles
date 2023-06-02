final: prev:
{
  quark-goldleaf = prev.callPackage ../packages/quark-goldleaf { };
  vscode-extensions = prev.vscode-extensions // prev.callPackage ../packages/vscode-extensions { };
  jetbrains-mono-nerdfont = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
}
