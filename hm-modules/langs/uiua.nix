{ pkgs, lib, config, ... }:
let
  cfg = config.modules.langs.uiua;
in
{
  options.modules.langs.uiua = {
    enable = lib.mkEnableOption "uiua";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.dev-uiua; [
      uiua
    ];

    programs.vscode.extensions = with pkgs.dev-uiua.vscode-extensions; [
      uiua-lang.uiua-vscode
    ];
  };
}
