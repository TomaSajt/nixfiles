{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.unstable.vscode-extensions; [
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
    ];

    /*
    userSettings = {
      "emmet.includeLanguages" = {
        "django-html" = "html";
      };
      "svelte.enable-ts-plugin" = true;
      "git.autofetch" = true;

      "workbench.iconTheme" = "material-icon-theme";
    };
    */

  };
}

