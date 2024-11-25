{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/07f48745be31ac617da1da81d925689b25a9e308";
    nixpkgs-lanraragi.url = "github:TomaSajt/nixpkgs/lanraragi";
    nixpkgs-picom.url = "github:NixOS/nixpkgs/3b5b0af7c6dbde41f287bded4f5cb7d2d2c03ab3";
    nixpkgs-sway.url = "github:NixOS/nixpkgs/0fcb98acb6633445764dafe180e6833eb0f95208";

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
      nixpkgs-lanraragi,
      nixpkgs-picom,
      nixpkgs-sway,
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
            (_: _: { lanraragi = (mkPkgs' nixpkgs-lanraragi [ ]).lanraragi; })
            (_: _: { picom = (mkPkgs' nixpkgs-picom [ ]).picom; })
            (_: _: { sway-unwrapped = (mkPkgs' nixpkgs-sway [ ]).sway-unwrapped; })
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
