{ inputs, ... }:
{
  flake.modules.nixos.copyparty = {

    imports = [
      inputs.copyparty.nixosModules.default
    ];

    nixpkgs.overlays = [
      inputs.copyparty.overlays.default
    ];

    networking.firewall = {
      allowedUDPPorts = [
        3210
      ];
      allowedTCPPorts = [
        3210
      ];
    };

    services.copyparty = {
      enable = true;
      # directly maps to values in the [global] section of the copyparty config.
      # see `copyparty --help` for available options
      settings = {
        i = "0.0.0.0";
        p = [ 3210 ];
        # use booleans to set binary flags
        no-reload = true;
        # using 'false' will do nothing and omit the value when generating a config
        ignored-flag = false;
      };

      # create users
      accounts = {
        toma.passwordFile = "/run/keys/copyparty/toma_password";
      };

      # create a volume
      volumes = {
        # create a volume at "/" (the webroot), which will
        "/" = {
          # share the contents of "/srv/copyparty"
          path = "/srv/copyparty";
          # see `copyparty --help-accounts` for available options
          access = {
            # everyone gets read-access, but
            "r" = "*";
            "rwmda." = [ "toma" ];
          };
          # see `copyparty --help-flags` for available options
          flags = {
            # "fk" enables filekeys (necessary for upget permission) (4 chars long)
            fk = 4;
            # scan for new files every 60sec
            scan = 60;
            # volflag "e2d" enables the uploads database
            e2d = true;
            # "d2t" disables multimedia parsers (in case the uploads are malicious)
            d2t = true;
            # skips hashing file contents if path matches *.iso
            nohash = "\.iso$";
          };
        };
      };
      # you may increase the open file limit for the process
      openFilesLimit = 8192;
    };
  };
}
