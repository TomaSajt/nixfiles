final: prev:
{
  quark-goldleaf = prev.callPackage ./quark-goldleaf { };
  vscode-extensions = prev.vscode-extensions // prev.callPackage ./vscode-extensions { };
  vimPlugins = prev.vimPlugins // prev.callPackage ./vim-plugins { };
}
