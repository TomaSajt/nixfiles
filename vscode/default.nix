{ pkgs, ... }:
{

  home-manager.users.toma = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
    };
  };

}
