{
  flake.modules.nixos."hosts/toma-nixos-probook" =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home-manager.users.toma = {
        modules.alacritty.font-size = if config.withWayland then 12 else 8;
        home.packages = [ ];
      };

      networking.networkmanager.enable = true;

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
    };
}
