{
  flake.modules.nixos.graphical =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      config = lib.mkIf (config.wm == "niri") {
        programs.niri.enable = true;
      };
    };

  flake.modules.homeManager.graphical =
    {
      pkgs,
      lib,
      config,
      osConfig,
      ...
    }:
    {
      config = lib.mkIf (osConfig.wm == "niri") {
        xdg.configFile."niri/config.kdl".source = ./config.kdl;

        programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)

        home.packages = with pkgs; [
          xwayland-satellite # xwayland support
        ];
      };
    };
}
