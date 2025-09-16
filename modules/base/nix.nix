{ inputs, ... }:
{
  flake.modules.nixos.base = {
    nix =
      let
        emptyRegisty = builtins.toFile "empty-flake-registry.json" ''{"flakes":[], "version":2}'';
        lock = builtins.fromJSON (builtins.readFile ../../flake.lock);
      in
      {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [ "https://nix-community.cachix.org" ];
          trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
          flake-registry = emptyRegisty;
          auto-optimise-store = false;
          warn-dirty = false;
          log-lines = 33;
        };
        # Hack ----> Profit
        registry = {
          nixpkgs.to = lock.nodes.nixpkgs.locked;
        };
        # point <nixpkgs> to our flake's path
        channel.enable = false;
        nixPath = [ "nixpkgs=flake:${inputs.nixpkgs}" ];
      };
  };
}
