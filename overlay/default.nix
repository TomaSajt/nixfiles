final: prev:
{
  quark-goldleaf = prev.callPackage ../packages/quark-goldleaf { };
  dyalog-apl = prev.callPackage ../packages/dyalog-apl { };
  vscode-extensions = prev.vscode-extensions // prev.callPackage ../packages/vscode-extensions { };
  jetbrains-mono-nerdfont = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
}
