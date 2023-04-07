{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          unstableOverlay
          (import ./overlay)
        ];
      };

      unstableOverlay = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };


      specialArgs = {
        inherit inputs system;
      };

      mkHost = path: with inputs.nixpkgs.lib; nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            imports = [
              path # per-host system config
              ./. # global system config
            ];
            nixpkgs.pkgs = pkgs;
            networking.hostName = mkDefault "toma-nixos-${(removeSuffix ".nix" (baseNameOf path))}";
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.toma.imports = [ ./home ]; # global home config
            };
          }
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
