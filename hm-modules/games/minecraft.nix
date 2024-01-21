{ pkgs, lib, config, ... }:

let
  cfg = config.modules.games.minecraft;
in
{
  options.modules.games.minecraft = {
    enable = lib.mkEnableOption "minecraft";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      SPGoding.datapack-language-server
      arcensoth.language-mcfunction
    ];
  };
}
