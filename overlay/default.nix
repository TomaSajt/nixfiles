final: prev:
{
  quark-goldleaf = prev.callPackage ../packages/quark-goldleaf { };
  vscode-extensions = prev.vscode-extensions // import ../packages/vscode-extensions prev;
  jetbrains-mono-nerdfont = prev.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
}
