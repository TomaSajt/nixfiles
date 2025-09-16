{ inputs, ... }:
{
  flake.modules.nixos.base = {

    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    programs.nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = false;
    };

  };
}
