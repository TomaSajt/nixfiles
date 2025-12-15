{ inputs, ... }:
{
  flake.modules.homeManager.dev =
    {
      pkgs,
      lib,
      config,
      system,
      ...
    }:

    let
      cfg = config.modules.langs.lean4;

      #pkgs-lean = import inputs.nixpkgs-lean { system = pkgs.hostPlatform.system; };
    in
    {
      options.modules.langs.lean4 = {
        enable = lib.mkEnableOption "lean4";
      };

      config = lib.mkIf cfg.enable {
        home.packages = [
          pkgs.elan
          #pkgs-lean.lean4
        ];

        programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
          tamasfe.even-better-toml
          (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
            mktplcRef = {
              name = "lean4";
              publisher = "leanprover";
              version = "0.0.215";
              sha256 = "sha256-RLHrl6qqXGObffRqyTAU4GihJNjwhy21d4Dn0QjqM6o=";
            };
          })
        ];
      };
    };
}
