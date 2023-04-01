{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
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

      mkHost = path: with nixpkgs.lib; nixosSystem {
        inherit system;
        specialArgs = { inherit inputs system; };
        modules = [
          {
            nixpkgs.pkgs = pkgs;
            networking.hostName = mkDefault "toma-nixos-${(removeSuffix ".nix" (baseNameOf path))}";
          }
          ./. # default.nix
          path
        ];
      };
    in
    {
      nixosConfigurations = {
        toma-nixos-desktop = mkHost ./hosts/desktop;
        toma-nixos-thinkpad-school = mkHost ./hosts/thinkpad-school;
      };
    };
}