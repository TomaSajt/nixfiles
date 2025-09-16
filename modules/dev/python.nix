{
  flake.modules.homeManager.dev =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    let
      cfg = config.modules.langs.python;
    in
    {
      options.modules.langs.python = {
        enable = lib.mkEnableOption "python";
      };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ python3 ];

        programs.vscode.profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            # ms-python.python
            batisteo.vscode-django
          ];
          userSettings = {
            "emmet.includeLanguages" = {
              "django-html" = "html";
            };
          };
        };
      };
    };
}
