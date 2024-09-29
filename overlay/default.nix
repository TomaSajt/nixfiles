final: prev: {
  vscode-extensions = prev.vscode-extensions // prev.callPackage ./vscode-extensions { };
  vimPlugins = prev.vimPlugins // prev.callPackage ./vim-plugins { };
  osu-mime-types = prev.callPackage ./osu-mime-types { };
  dyalog = prev.dyalog.override { acceptLicense = true; };
  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (prevAttrs: {
    patches = prevAttrs.patches or [ ] ++ [
      (final.fetchpatch {
        url = "https://github.com/NickHu/sway/compare/1a3cfc50c15124c2be18c025e609112ee15de4aa...03c14421354e54332e12f78d029dcaa9919fd161.patch";
        hash = "sha256-P7ede/4csFycKq5dW9Z5PrqVg+8if3xIm+T8dT4Z7b0=";
      })
    ];
  });

}
