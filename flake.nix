{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #nixpkgs-extra.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    rycee-nur.url = "gitlab:rycee/nur-expressions";
    rycee-nur.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      #nixpkgs-extra,
      home-manager,
      nixos-hardware,
      nix-index-database,
      rycee-nur,
    }@inputs:

    let
      mkPkgs =
        system: pkgs-flake: overlays:
        import pkgs-flake {
          inherit system overlays;
          config.allowUnfree = true;
        };

      mkHost =
        {
          system,
          hostName,
          hostModule,
        }:
        let
          specialArgs = {
            inherit inputs;
          };

          mkPkgs' = mkPkgs system;

          pkgs = mkPkgs' nixpkgs [
            (import ./overlay)
            #(_: _: { inherit (mkPkgs' nixpkgs-extra [ ]) bruh; })
          ];
        in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./. # global system config
            hostModule # per host configs
            {
              networking.hostName = hostName;
              nixpkgs.pkgs = pkgs;
              home-manager = {
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        "toma-nixos-desktop-home" = mkHost {
          system = "x86_64-linux";
          hostName = "toma-nixos-desktop-home";
          hostModule = ./hosts/desktop-home;
        };
        "toma-nixos-thinkpad-school" = mkHost {
          system = "x86_64-linux";
          hostName = "toma-nixos-thinkpad-school";
          hostModule = ./hosts/thinkpad-school;
        };
        "toma-nixos-server-home" = mkHost {
          system = "x86_64-linux";
          hostName = "toma-nixos-server-home";
          hostModule = ./hosts/server-home;
        };
        "toma-nixos-rpi4-home" = mkHost {
          system = "aarch64-linux";
          hostName = "toma-nixos-rpi4-home";
          hostModule = ./hosts/rpi4-home;
        };
      };
    };
}
