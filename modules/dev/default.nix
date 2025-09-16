{
  flake.modules.homeManager.dev =
    { lib, ... }:
    {
      modules = {
        vscode.enable = lib.mkDefault true;
        langs = {
          cpp.enable = lib.mkDefault true;
          dotnet.enable = lib.mkDefault true;
          dyalog.enable = lib.mkDefault true;
          javascript.enable = lib.mkDefault true;
          python.enable = lib.mkDefault true;
          rust.enable = lib.mkDefault true;
          uiua.enable = lib.mkDefault true;
        };
      };
    };
}
