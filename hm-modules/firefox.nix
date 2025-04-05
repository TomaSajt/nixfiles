{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

# Parts stolen from https://github.com/mahmoudk1000/nix-config/blob/main/modules/programs/firefox.nix

let
  cfg = config.modules.firefox;

  firefox-addons = (import inputs.rycee-nur { inherit pkgs; }).firefox-addons;

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
      default = "ddg";
      engines = {
        "nixpkgs" = {
          name = "Nix Packages";
          urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@p" ];
        };
        "nixos-opts" = {
          name = "NixOS Options";
          urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@o" ];
        };
        "hm-opts" = {
          name = "Home Manager Options";
          urls = [
            { template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
        "github" = {
          name = "Github Search";
          urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@gh" ];
        };
        "github-nixpkgs" = {
          name = "Github Search Nixpkgs";
          urls = [ { template = "https://github.com/search?q=repo%3ANixOS%2Fnixpkgs+{searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@gn"
            "@ghn"
          ];
        };
        "terraria-wiki" = {
          name = "Terraria Wiki";
          urls = [ { template = "https://terraria.wiki.gg/index.php?search={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@tw" ];
        };
        "aplcart" = {
          name = "APLCart";
          urls = [ { template = "https://aplcart.info/?q={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@apl"
            "@apc"
          ];
        };
        "google-translate" = {
          name = "Google Translate";
          urls = [
            { template = "https://translate.google.com/?sl=auto&tl=hu&op=translate&text={searchTerms}"; }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@tr"
            "@gt"
          ];
        };
        "repology-proj" = {
          name = "Repology Projects";
          urls = [ { template = "https://repology.org/projects/?search={searchTerms}"; } ];
          icon = "${repology-logo}/repology-logo.svg";
          definedAliases = [
            "@re"
            "@rep"
          ];
        };
        "repology-maintainers" = {
          name = "Repology Maintainers";
          urls = [ { template = "https://repology.org/maintainers/?search={searchTerms}"; } ];
          icon = "${repology-logo}/repology-logo.svg";
          definedAliases = [ "@rem" ];
        };
        "jisho" = {
          name = "Jisho";
          urls = [ { template = "https://jisho.org/search/{searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [
            "@jp"
            "@ji"
          ];
        };
        "google".metaData.alias = "@g";
        "wikipedia".metaData.alias = "@w";
        "amazon".metaData.hidden = true;
        "bing".metaData.hidden = true;
        "ebay".metaData.hidden = true;
      };
      order = [
        "ddg"
        "google"
        "wikipedia"
        "nixpkgs"
        "nixos-opts"
        "hm-opts"
        "github"
        "github-nixpkgs"
        "terraria-wiki"
        "aplcart"
        "google-translate"
        "repology-proj"
        "repology-maintainers"
        "jisho"
      ];
    };
    extensions.packages = with firefox-addons; [
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
