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

      inherit (pkgs) lib;

      specialArgs = {
        inherit inputs system;
      };

      mkHost = path: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = [
          {
            imports = [
              path # per-host system config
              ./. # global system config
            ];
            networking.hostName = lib.mkDefault (builtins.baseNameOf path);
            nixpkgs.pkgs = pkgs;
            home-manager.extraSpecialArgs = specialArgs;
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
