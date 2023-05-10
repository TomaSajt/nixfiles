{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nur.url = github:nix-community/NUR;

    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
          inputs.nur.overlay
          (import ./overlay)
        ];
      };
      unstableOverlay = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.fenix.overlays.default
            (import ./overlay)
          ];
        };
      };

      inherit (pkgs) lib;

      specialArgs = {
        inherit inputs system;
      };

      mkHost = path: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = [
          path # per-host system config
          ./. # global system config
          inputs.nur.nixosModules.nur
          inputs.home-manager.nixosModules.home-manager
          # Extra setup
          {
            networking.hostName = lib.mkDefault (builtins.baseNameOf path);
            nixpkgs.pkgs = pkgs;
            home-manager = {
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.toma = import ./home;
            };
          }
        ];
      };

      mapDirModules = dir: fn:
        let
          dirData = builtins.readDir dir;
          mappedAttrs = lib.mapAttrs'
            (n: v:
              let path = dir + "/${n}"; in
              if v == "directory" && lib.pathExists (path + "/default.nix")
              then lib.nameValuePair n (fn path)
              else lib.nameValuePair "" null
            )
            dirData;

        in
        lib.filterAttrs (_: v: v != null) mappedAttrs;
    in
    {
      nixosConfigurations = mapDirModules ./hosts mkHost;
    };
}
