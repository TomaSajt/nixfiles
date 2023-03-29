{ pkgs }: with pkgs;
vscode-utils.buildVscodeMarketplaceExtension
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
}
