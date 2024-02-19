{ vscode-utils, lib, ... }:
{
  arcensoth.language-mcfunction = vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "language-mcfunction";
      publisher = "arcensoth";
      version = "0.18.0";
      sha256 = "KRLY8T8ubvXxDz1nJ+Uhd2gqhiTquf5yonDX2aPy6Cs=";
    };
    meta = with lib; {
      license = licenses.mit;
    };
  };
  SPGoding.datapack-language-server = vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "datapack-language-server";
      publisher = "SPGoding";
      version = "3.2.0";
      sha256 = "RdDVpZ+uZiVR6agkdpa5ZeqO5TnQ9M9xI645JKXGs/c=";
    };
    meta = with lib; {
      license = licenses.mit;
    };
  };
  antfu.unocss = vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "unocss";
      publisher = "antfu";
      version = "0.52.5";
      sha256 = "sha256-NU0yv/+bwPcUpNaZICENEnraNDvJiAkBELeOgoMlBtc=";
    };
  };
}
