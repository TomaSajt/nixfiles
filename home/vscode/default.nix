{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
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
}

