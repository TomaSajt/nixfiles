{
  inputs,
  lib,
  config,
  ...
}:

let
  prefix = "hosts/";
  collectHostsModules = modules: lib.filterAttrs (name: _: lib.hasPrefix prefix name) modules;
  hostModules = collectHostsModules config.flake.modules.nixos;

  mkConfig =
    hostModuleName: hostModule:
    let
      hostName = lib.removePrefix prefix hostModuleName;
      specialArgs = {
        inherit inputs;
        hostExtraInfo = {
          name = hostName;
        };
      };
    in
    {
      name = hostName;
      value = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          hostModule
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
        ];
      };
    };
in
{
  flake.nixosConfigurations = lib.mapAttrs' mkConfig hostModules;
}
