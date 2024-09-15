{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

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
        system: hostName:
        let
          specialArgs = {
            inherit inputs system;
          };

          mkPkgs' = mkPkgs system;

          pkgs = mkPkgs' nixpkgs [
            (import ./overlay)
            #(_: _: { dev-uiua = mkPkgs nixpkgs-uiua [ ]; })
          ];
        in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/${hostName} # per-host system config
            ./. # global system config
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
        "toma-nixos-desktop-home" = mkHost "x86_64-linux" "toma-nixos-desktop-home";
        "toma-nixos-thinkpad-school" = mkHost "x86_64-linux" "toma-nixos-thinkpad-school";
        "toma-nixos-server-home" = mkHost "x86_64-linux" "toma-nixos-server-home";
        "toma-nixos-rpi4-home" = mkHost "aarch64-linux" "toma-nixos-rpi4-home";
      };
    };
}
