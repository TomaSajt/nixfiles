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
    home.packages = with pkgs; [ python311 ];

    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        batisteo.vscode-django
      ];
      userSettings = {
        "emmet.includeLanguages" = {
          "django-html" = "html";
        };
      };
    };
  };
}
