{
  inputs = {
    nixpkgs.url = github:TomaSajt/nixpkgs/lanraragi;
    nixpkgs-dev1.url = github:TomaSajt/nixpkgs/ride;
    nixpkgs-dev2.url = github:NixOS/nixpkgs/c585eaf8d88cbcd32935f7865f1e2568f8f5e9ce;
    nixpkgs-dev-uiua.url = github:NixOS/nixpkgs;
    nixpkgs-dev3.url = github:TomaSajt/nixpkgs/quark-goldleaf;

    nur.url = github:nix-community/NUR;

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-review-checks.url = github:SuperSandro2000/nixpkgs-review-checks;
    nixpkgs-review-checks.inputs.nixpkgs.follows = "nixpkgs";


    nixpkgs-droid.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    nix-on-droid.url = github:nix-community/nix-on-droid;
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-droid";
    nix-on-droid.inputs.home-manager.follows = "home-manager";
   
  };

  outputs = inputs: with inputs;
    let
      system = "x86_64-linux";

      mkPkgs = pkgs-flake: system: overlays: import pkgs-flake {
        inherit system;
        config.allowUnfree = true;
        inherit overlays;
      };

      pkgs = mkPkgs nixpkgs "x86_64-linux" [
        (import ./overlay)
        nur.overlay
        (_: _: {
          dev1 = mkPkgs nixpkgs-dev1 "x86_64-linux" [ ];
          dev2 = mkPkgs nixpkgs-dev2 "x86_64-linux" [ ];
          dev3 = mkPkgs nixpkgs-dev3 "x86_64-linux" [ ];
          dev-uiua = mkPkgs nixpkgs-dev-uiua "x86_64-linux" [ ];
        })
      ];

      inherit (pkgs) lib;

      specialArgs = {
        inherit inputs;
        system = "x86_64-linux";
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
    rec {
      nixosConfigurations = mapDirModules ./hosts mkHost;
      
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [ ./droid.nix ];
      };

      inherit pkgs;
      droid-pkgs = nixOnDroidConfigurations.default.pkgs;
    };
}
