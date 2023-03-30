{ pkgs, ... }:
{

  home-manager.users.toma = { pkgs, ... }: {
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
      ];
    };
  };

}

