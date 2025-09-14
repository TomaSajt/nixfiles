{
  flake.modules.nixos."hosts/toma-nixos-rpi4-home" =
    { pkgs, ... }:
    # stolen from https://github.com/samhh/dotfiles/blob/f4a32fb6c9d73b022a696ac06badc7a7c0827163/hosts/tentacool/svc/blocky.nix
    let
      dnsPort = 53;
      apiPort = 4000;
      router = "192.168.0.1";
    in
    {
      networking.firewall.allowedTCPPorts = [
        dnsPort
        apiPort
      ];
      networking.firewall.allowedUDPPorts = [
        dnsPort
      ];

      services.blocky = {
        enable = true;
        settings = {
          ports = {
            dns = dnsPort;
            http = apiPort;
          };

          # Blocky picks two servers at random and races them. This also has various
          # privacy implications.
          upstream.default = [
            "9.9.9.9" # Quad9
            "8.8.8.8" # Google
          ];

          # Point to the router for local hostname resolution...
          clientLookup.upstream = router;
          # ...as well as for non-FQDN hostnames e.g. `tentacool` (else blocky sees
          # `tentacool.localdomain`). This is also necessary for UniFi adoption.
          conditional.mapping."." = router;

          blocking = {
            blackLists = {
              personal = [
                "https://dbl.oisd.nl"
                "https://adaway.org/hosts.txt"
                "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
                "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
                "https://v.firebog.net/hosts/Easyprivacy.txt"
                "https://v.firebog.net/hosts/static/w3kbl.txt"
                "https://v.firebog.net/hosts/Prigent-Ads.txt"
                "https://v.firebog.net/hosts/Prigent-Crypto.txt"
                "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
              ];
            };

            # At time of writing Nix outputs YAML via remarshal, which doesn't
            # preserve the inline format Blocky wants here in a round-trip, so
            # presumably it's not possible. Hence the use of a filepath.
            whiteLists =
              # Domains here will be matched exactly if not defined as regex, see:
              #   https://github.com/0xERR0R/blocky/issues/556#issuecomment-1150731243
              let
                personalWhitelist = pkgs.writeText "personal-whitelist" ''
                  www.googleadservices.com
                '';
              in
              {
                personal = [ personalWhitelist ];
              };

            clientGroupsBlock = {
              default = [ "personal" ];
            };

            # Similar to `caching.cacheTimeNegative`, it's more practical for
            # clients to be more reactive to configuration changes.
            blockTTL = "1m";

            # Briefly expose the network to unfiltered DNS to get the network up as
            # fast as possible when blocky restarts.
            startStrategy = "fast";
          };

          # If a query fails it might be that I'm fiddling with it so it's just a
          # temporary outage, see:
          #   https://github.com/0xERR0R/blocky/issues/287
          caching.cacheTimeNegative = "1m";
        };
      };
    };
}
