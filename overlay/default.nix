newPkgs: pkgs:
{
  quark-goldleaf = import ./quark-goldleaf pkgs;
  vscode-extensions = pkgs.vscode-extensions // import ./vscode-extensions pkgs;
}
