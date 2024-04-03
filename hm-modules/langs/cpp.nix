{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.langs.cpp;
in
{
  options.modules.langs.cpp = {
    enable = lib.mkEnableOption "cpp";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        gcc
        gdb
      ];
    };

    programs.vscode.extensions = with pkgs.vscode-extensions; [ ms-vscode.cpptools ];
  };
}
