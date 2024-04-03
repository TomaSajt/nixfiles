{
  pkgs,
  lib,
  config,
  ...
}:
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

  repology-logo = pkgs.fetchFromGitHub {
    owner = "repology";
    repo = "repology-logo";
    rev = "3ea2198d4c7dc2ded5a2269aef906c2097d9c41e";
    hash = "sha256-q1fin92PO913/gxQtpLORDn/0Ciiq9GAiUeQGYP4044=";
  };

  shared = {
    search = {
      force = true;
      default = "DuckDuckGo";
      engines = {
        "Nix Packages" = {
          urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@p" ];
        };
        "NixOS Options" = {
          urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@o" ];
        };
        "Home Manager Options" = {
          urls = [
            { template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
        "Github Search" = {
          urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@gh" ];
        };
        "Github Search Nixpkgs" = {
          urls = [ { template = "https://github.com/search?q=repo%3ANixOS%2Fnixpkgs+{searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@gn"
            "@ghn"
          ];
        };
        "Terraria Wiki" = {
          urls = [ { template = "https://terraria.wiki.gg/index.php?search={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@tw" ];
        };
        "APLCart" = {
          urls = [ { template = "https://aplcart.info/?q={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@apl"
            "@apc"
          ];
        };
        "Google Translate" = {
          urls = [
            { template = "https://translate.google.com/?sl=auto&tl=hu&op=translate&text={searchTerms}"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@tr"
            "@gt"
          ];
        };
        "Repology Projects" = {
          urls = [ { template = "https://repology.org/projects/?search={searchTerms}"; } ];
          icon = "${repology-logo}/repology-logo.svg";
          definedAliases = [
            "@re"
            "@rep"
          ];
        };
        "Repology Maintainers" = {
          urls = [ { template = "https://repology.org/maintainers/?search={searchTerms}"; } ];
          icon = "${repology-logo}/repology-logo.svg";
          definedAliases = [ "@rem" ];
        };
        "Jisho" = {
          urls = [ { template = "https://jisho.org/search/{searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@jp"
            "@ji"
          ];
        };
        "Google".metaData.alias = "@g";
        "Wikipedia (en)".metaData.alias = "@w";
        "Amazon.com".metaData.hidden = true;
        "Bing".metaData.hidden = true;
        "eBay".metaData.hidden = true;
      };
      order = [
        "DuckDuckGo"
        "Google"
        "Wikipedia (en)"
        "Nix Packages"
        "NixOS Options"
        "Home Manager Options"
        "Github Search"
        "Github Search Nixpkgs"
        "Terraria Wiki"
        "APLCart"
        "Google Translate"
      ];
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      bitwarden
      darkreader
      sponsorblock
      tampermonkey
    ];
    settings = {
      "browser.aboutConfig.showWarning" = false; # Don't show warning when viewing about:config
      "extensions.autoDisableScopes" = 0; # Automatically enable extensions (maybe unsafe, idc)
      "browser.translations.automaticallyPopup" = false;
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
