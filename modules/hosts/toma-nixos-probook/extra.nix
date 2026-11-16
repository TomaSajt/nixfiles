{
  flake.modules.nixos."hosts/toma-nixos-probook" =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    let
      septabee =
        with pkgs;
        stdenv.mkDerivation {
          pname = "septabee";
          version = "0-B-T28";

          src = fetchurl {
            url = "https://downloads.septabee.com/SEPTABEE_DOWNLOADS/septabee_linux_B_T28_offline.7z";
            hash = "sha256-J6oXQhoQkCs4UbrdWhiRjbO+PCDLdcLKmKVZ7fHuWHk=";
          };

          nativeBuildInputs = [ _7zz ];

          installPhase = ''
            runHook preInstall

            install -Dt "$out/share/septabee" *

            mkdir -p "$out/bin"
            ln -s "$out/share/septabee/septabee" "$out/bin/septabee"

            runHook postInstall
          '';
        };
    in
    {
      security.wrappers.septabee = {
        owner = "root";
        group = "root";
        capabilities = "cap_sys_nice+ep";
        source = "${lib.getExe septabee}";
      };

      services.transmission = {
        enable = false;
        package = pkgs.transmission_4;
        downloadDirPermissions = "775";
        settings = {
          download-dir = "/transmission/download";
          incomplete-dir = "/transmission/.incomplete";
        };
      };

      #services.timesyncd.enable = false;

      hardware.bluetooth.enable = true;

      #virtualisation.vmware.host.enable = true;
      virtualisation.virtualbox.host.enable = true;

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
                cacerts = [ "/etc/ssl/certs/HARICA-TLS-Root-2021-RSA.cer" ];
              };

              children."bme" = {
                remote_ts = [ "0.0.0.0/0" ];
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
