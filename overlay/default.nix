final: prev: {
  vscode-extensions = prev.vscode-extensions // prev.callPackage ./vscode-extensions { };
  vimPlugins = prev.vimPlugins // prev.callPackage ./vim-plugins { };
  osu-mime-types = prev.callPackage ./osu-mime-types { };
  dyalog = prev.dyalog.override { acceptLicense = true; };
  /*
    sway-unwrapped = prev.sway-unwrapped.overrideAttrs (prevAttrs: {
      patches = prevAttrs.patches or [ ] ++ [
        (final.fetchpatch {
          url = "https://patch-diff.githubusercontent.com/raw/swaywm/sway/pull/8405.patch";
          hash = "sha256-poblUEaeytBD8xqfiW0lRWaJ12RZ1meLGjZPl7JBrOo=";
        })
      ];
    });
  */

}
