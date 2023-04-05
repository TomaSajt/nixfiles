{ vscode-utils, lib, ... }:
{
  arcensoth.language-mcfunction = vscode-utils.buildVscodeMarketplaceExtension
    {
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
  batisteo.vscode-django = vscode-utils.buildVscodeMarketplaceExtension
    {
      mktplcRef = {
        name = "vscode-django";
        publisher = "batisteo";
        version = "1.10.0";
        sha256 = "vTaE3KhG5i2jGc5o33u76RUUFYaW4s4muHvph48HeQ4=";
      };
      meta = with lib; {
        license = licenses.mit;
      };
    };
  SPGoding.datapack-language-server = vscode-utils.buildVscodeMarketplaceExtension
    {
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
}
