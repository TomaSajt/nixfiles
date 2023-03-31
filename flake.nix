{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: { unstable = pkgs'; })
          (import ./overlay)
        ];
      };
      pkgs' = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      nixosConfigurations.toma-nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          [
            {
              nixpkgs.pkgs = pkgs;
            }
            ./hosts/desktop
          ];
      };
      nixosConfigurations.toma-nixos-thinkpad-school = nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          [
            {
              nixpkgs.pkgs = pkgs;
            }
            ./hosts/thinkpad-school
          ];
      };


    };
}
