{ pkgs, lib, config, ... }:

let
  cfg = config.modules.code-editors.vscode;
in
{
  options.modules.code-editors.vscode = {
    enable = lib.mkEnableOption "vscode";
    codium = lib.mkEnableOption "use vscodium";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = if cfg.codium then pkgs.vscodium else pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        svelte.svelte-vscode
        pkief.material-icon-theme
        ms-vscode.cpptools
        ms-python.python
        ms-dotnettools.csharp
        batisteo.vscode-django
        SPGoding.datapack-language-server
        arcensoth.language-mcfunction
        arrterian.nix-env-selector
        bradlc.vscode-tailwindcss
        antfu.unocss

        pkgs.dev-uiua.vscode-extensions.uiua-lang.uiua-vscode
      ];

      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";

        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        "emmet.includeLanguages" = {
          "django-html" = "html";
        };

        "typescript.updateImportsOnFileMove.enabled" = "always";
        "svelte.enable-ts-plugin" = true;

        "git.openRepositoryInParentFolders" = "always";
      };
    };
  };
}

