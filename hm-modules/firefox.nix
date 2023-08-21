{ pkgs, lib, config, ... }:
# Parts stolen from https://github.com/mahmoudk1000/nix-config/blob/main/modules/programs/firefox.nix

let
  cfg = config.modules.firefox;

  firefox-wrapped = pkgs.wrapFirefox pkgs.firefox-unwrapped {
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

  shared = {
    search = {
      force = true;
      default = "DuckDuckGo";
      engines = {
        "Nix Packages" = {
          urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@p" ];
        };
        "NixOS Options" = {
          urls = [{ template = "https://search.nixos.org/options?query={searchTerms}"; }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@o" ];
        };
        "Home Manager Options" = {
          urls = [{ template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}"; }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
        "Nixpkgs Github" = {
          urls = [{ template = "https://github.com/search?q=repo%3ANixOS%2Fnixpkgs+{searchTerms}&type=code"; }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@gh" ];
        };
        "Terraria Wiki" = {
          urls = [{ template = "https://terraria.wiki.gg/index.php?search={searchTerms}"; }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@tw" ];
        };
        "Google".metaData.alias = "@g";
        "Wikipedia (en)".metaData.alias = "@w";
        "Amazon.com".metaData.hidden = true;
        "Bing".metaData.hidden = true;
        "eBay".metaData.hidden = true;
      };
      order = [ "DuckDuckGo" "Google" "Nix Packages" "NixOS Options" "Home Manager Options" "Nixpkgs Github" "Wikipedia (en)" "Terraria Wiki" ];
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      bitwarden
      darkreader
      sponsorblock
      tampermonkey
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
  options.modules.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf cfg.enable {

    modules.mime-apps.associations = {
      "application/pdf" = "firefox.desktop";
    };

    programs.firefox = {
      enable = true;
      package = firefox-wrapped;
      profiles = {
        main = shared // {
          id = 0;
          isDefault = true;
        };
        school = shared // {
          id = 1;
          isDefault = false;
        };
      };
    };
  };
}