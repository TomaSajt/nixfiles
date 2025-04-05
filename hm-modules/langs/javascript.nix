{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.langs.javascript;
in
{
  options.modules.langs.javascript = {
    enable = lib.mkEnableOption "javascript";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        nodejs
        nodejs.pkgs.pnpm
      ];
    };

    programs.vscode.profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        svelte.svelte-vscode
        bradlc.vscode-tailwindcss
      ];
      userSettings = {
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "svelte.enable-ts-plugin" = true;
      };
    };
  };
}
