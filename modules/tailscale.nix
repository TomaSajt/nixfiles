{
  flake.modules.nixos.tailscale =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options = {
        custom.tailscale.enableNMWorkaround = lib.mkEnableOption "NetworkManager workaround for tailscale";
      };
      config = {
        services.tailscale.enable = true;

        # https://github.com/NixOS/nixpkgs/issues/180175
        systemd.services.NetworkManager-wait-online = lib.mkIf config.custom.tailscale.enableNMWorkaround {
          serviceConfig = {
            ExecStart = [
              ""
              "${pkgs.networkmanager}/bin/nm-online -q"
            ];
          };
        };
      };
    };
}
