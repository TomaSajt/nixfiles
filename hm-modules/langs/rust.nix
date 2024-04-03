{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.langs.rust;
in
{
  options.modules.langs.rust = {
    enable = lib.mkEnableOption "rust";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        rustc
        cargo
        rustfmt
      ];
    };

    programs.vscode.extensions = with pkgs.vscode-extensions; [ rust-lang.rust-analyzer ];
  };
}
