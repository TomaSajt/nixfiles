{
  flake.modules.nixos.graphical =
    { lib, ... }:
    {
      options = {
        wm = lib.mkOption {
          type = lib.types.enum [
            "sway"
            "i3"
            "niri"
          ];
        };
      };

      config = {
        wm = lib.mkDefault "sway";

        specialisation."i3".configuration = {
          wm = "i3";
        };

        specialisation."niri".configuration = {
          wm = "niri";
        };
      };
    };
}
