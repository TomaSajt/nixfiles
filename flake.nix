{
  inputs = {
    nixpkgs.url = github:TomaSajt/nixpkgs/lanraragi;
    #nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    nixpkgs-unstable.url = github:NixOS/nixpkgs;
    nixpkgs-dev1.url = github:TomaSajt/nixpkgs/ride;
    nixpkgs-dev3.url = github:TomaSajt/nixpkgs/quark-goldleaf;
    nixpkgs-dev4.url = github:TomaSajt/nixpkgs/actiona;

    nur.url = github:nix-community/NUR;

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-review-checks.url = github:SuperSandro2000/nixpkgs-review-checks;
    nixpkgs-review-checks.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs: with inputs;
    let
      system = "x86_64-linux";

      mkPkgs = pkgs-flake: overlays: import pkgs-flake {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays ++ [
          nur.overlay
          (import ./overlay)
        ];
      };

      pkgs = mkPkgs nixpkgs [
        (_: _: {
          unstable = mkPkgs nixpkgs-unstable [ ];
          dev1 = mkPkgs nixpkgs-dev1 [ ];
          dev3 = mkPkgs nixpkgs-dev3 [ ];
          dev4 = mkPkgs nixpkgs-dev4 [ ];
        })
      ];

      inherit (pkgs) lib;

      specialArgs = {
        inherit inputs system;
      };

      mkHost = path: nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          path # per-host system config
          ./. # global system config
          home-manager.nixosModules.home-manager
          # Extra setup
          {
            networking.hostName = lib.mkDefault (builtins.baseNameOf path);
            nixpkgs.pkgs = pkgs;
            home-manager = {
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.toma = import ./home.nix;
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
      inherit pkgs;
    };
}
