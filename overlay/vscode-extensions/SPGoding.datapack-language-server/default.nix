{ pkgs }: with pkgs;
vscode-utils.buildVscodeMarketplaceExtension
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
}
