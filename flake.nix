{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
          (import ./overlay)
        ];
      };
    in
    {

      nixosConfigurations.toma-nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          {
            nixpkgs.pkgs = pkgs;
          }
          ./hosts/desktop
          home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.toma-nixos-thinkpad-school = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          {
            nixpkgs.pkgs = pkgs;
          }
          ./hosts/thinkpad-school
          home-manager.nixosModules.default
          { }
        ];
      };
    };
}
