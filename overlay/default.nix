final: prev:
{
  vscode-extensions = prev.vscode-extensions // prev.callPackage ./vscode-extensions { };
  vimPlugins = prev.vimPlugins // prev.callPackage ./vim-plugins { };
  osu-mime-types = prev.callPackage ./osu-mime-types { };
  ccls = prev.callPackage ./ccls { llvmPackages = prev.llvmPackages_16; };
}
