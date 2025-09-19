{
  flake.modules.nixos."hosts/toma-nixos-probook" =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      services.transmission = {
        enable = true;
        downloadDirPermissions = "775";
        settings = {
          download-dir = "/transmission/download";
          incomplete-dir = "/transmission/.incomplete";
        };
      };

      # Enable touchpad support (with natural scrolling)
      services.libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      home-manager.users.toma =
        { osConfig, ... }:
        {
          custom.batterySupport = true;
          modules.git.signing = false;
          modules.alacritty.font-size = if osConfig.withWayland then 12 else 8;
          home.packages = [ ];
        };
    };
}
