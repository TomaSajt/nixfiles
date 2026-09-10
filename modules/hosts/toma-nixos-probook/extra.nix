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
        enable = false;
        package = pkgs.transmission_4;
        downloadDirPermissions = "775";
        settings = {
          download-dir = "/transmission/download";
          incomplete-dir = "/transmission/.incomplete";
        };
      };

      hardware.bluetooth.enable = true;

      virtualisation.vmware.host.enable = true;

      environment.etc."ipsec.secrets".text = ''
        include /etc/secrets/bmevpn-pass
      '';

      services.strongswan-swanctl = {
        enable = true;
        swanctl = {
          connections = {
            bme = {
              version = 2;
              remote_addrs = [ "vpn.net.bme.hu" ];
              vips = [ "0.0.0.0" ];

              local."main" = {
                auth = "eap-mschapv2";
                eap_id = "szam@bme.hu";
              };

              remote."main" = {
                auth = "pubkey";
                id = "vpn.net.bme.hu";
                cacerts = [ "/etc/ssl/certs/HARICA-TLS-Root-2021-RSA.cer" ];
              };

              children."bme" = {
                # start_action = "start";
                local_ts = [ "dynamic" ];
                remote_ts = [
                  "0.0.0.0/0"
                  "::/0"
                ];
              };
            };
          };
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
          modules.alacritty.font-size = if osConfig.wm == "i3" then 8 else 12;
          home.packages = [ ];
        };
    };
  nixpkgs.allowedUnfreePackages = [
    "vmware-workstation"
  ];
}
