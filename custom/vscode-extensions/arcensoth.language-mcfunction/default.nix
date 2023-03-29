{ pkgs }: with pkgs;
vscode-utils.buildVscodeMarketplaceExtension
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
}
