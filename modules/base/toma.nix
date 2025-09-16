{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      users.users.toma = {
        isNormalUser = true;
        description = "Toma";
        uid = 1000;
        extraGroups = [
          "networkmanager"
          "wheel"
          "transmission"
          "docker"
          "plugdev"
          "input"
          "terraria"
        ];
      };
    };
}
