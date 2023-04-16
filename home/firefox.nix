{ pkgs, lib, ... }: {
  # Parts stolen from here: https://github.com/mahmoudk1000/nix-config/blob/main/modules/programs/firefox.nix
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };
    profiles =
      let
        shared = {
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Nix Packages" = {
                urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@pkgs" ];
              };
              "Google".metaData.alias = "@g";
              "Wikipedia (en)".metaData.alias = "@wiki";
              "Amazon.com".metaData.hidden = true;
              "Bing".metaData.hidden = true;
              "eBay".metaData.hidden = true;
            };
            order = [ "DuckDuckGo" "Google" "Nix Packages" "Wikipedia (en)" ];
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            darkreader
          ];
          settings = {
            # Don't show warning when viewing about:config
            "browser.aboutConfig.showWarning" = false;

            # Automatically enable extensions (maybe unsafe, idc)
            "extensions.autoDisableScopes" = 0;

          };
        };
      in
      {
        main = lib.mkMerge [
          shared
          {
            id = 0;
            isDefault = true;
          }
        ];
        school = lib.mkMerge [
          shared
          {
            id = 1;
            isDefault = false;
          }
        ];
      };
  };
}
