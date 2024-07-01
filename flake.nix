{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-droid.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-on-droid.url = "github:nix-community/nix-on-droid";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-droid";
    nix-on-droid.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      nur,
      home-manager,
      nix-index-database,
      nixpkgs-droid,
      nix-on-droid,
    }@inputs:

    let
      mkPkgs =
        pkgs-flake: system: overlays:
        import pkgs-flake {
          inherit system overlays;
          config.allowUnfree = true;
        };

      mkPkgs' = pkgs-flake: overlays: mkPkgs pkgs-flake "x86_64-linux" overlays;

      pkgs = mkPkgs' nixpkgs [
        (import ./overlay)
        nur.overlay
        # (_: _: { dev-voicevox = mkPkgs' nixpkgs-dev-voicevox [ ]; })
      ];

      inherit (pkgs) lib;

      specialArgs = {
        inherit inputs;
      };

      mkHost =
        path:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            path # per-host system config
            ./. # global system config
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            {
              programs.nix-index = {
                enable = true;
                enableBashIntegration = false;
                enableFishIntegration = false;
                enableZshIntegration = false;
              };
            }
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

      droidConf = nix-on-droid.lib.nixOnDroidConfiguration { modules = [ ./droid.nix ]; };

      mapDirModules =
        dir: fn:
        let
          dirData = builtins.readDir dir;
          mappedAttrs = lib.mapAttrs' (
            n: v:
            let
              path = dir + "/${n}";
            in
            if v == "directory" && lib.pathExists (path + "/default.nix") then
              lib.nameValuePair n (fn path)
            else
              lib.nameValuePair "" null
          ) dirData;
        in
        lib.filterAttrs (_: v: v != null) mappedAttrs;
    in
    {
      inherit pkgs;
      nixosConfigurations = mapDirModules ./hosts mkHost;
      nixOnDroidConfigurations.default = droidConf;
      droid-pkgs = droidConf.pkgs;
    };
}
