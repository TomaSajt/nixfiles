{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.vscode;
in
{
  options.modules.vscode = {
    enable = lib.mkEnableOption "vscode";
    codium = lib.mkEnableOption "use vscodium";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = if cfg.codium then pkgs.vscodium else pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [ pkief.material-icon-theme ];

      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
      };
    };
  };
}
