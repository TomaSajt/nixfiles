{
  flake.modules.nixos."hosts/toma-nixos-desktop-home" =
    { lib, config, ... }:
    {

      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.stable; # 590 no longer supports my GPU
        prime = {
          sync.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:1:0";
        };
        modesetting.enable = true; # its true by default, but set it anyway
        forceFullCompositionPipeline = true;
      };

      environment.etc."X11/xorg.conf.d/10-disable-nvidia-phantom-monitor.conf" =
        lib.mkIf (!config.withWayland)
          {
            text = ''
              Section "Monitor"
                  Identifier "None-1-1"
                  Option "Ignore" "true"
              EndSection
            '';
          };

      home-manager.users.toma = {
        services.picom.vSync = false; # Turns off the default screen-tearing fix

        home.sessionVariables = {
          # https://bugs.webkit.org/show_bug.cgi?id=228268
          # fix for nvidia proprietary drivers
          "WEBKIT_DISABLE_COMPOSITING_MODE" = "1";
        };
      };
    };

  nixpkgs.allowedUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
