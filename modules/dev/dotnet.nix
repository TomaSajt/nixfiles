{
  flake.modules.homeManager.dev =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.modules.langs.dotnet;

      dotnet-sdks =
        with pkgs.dotnetCorePackages;
        combinePackages [
          sdk_11_0
          sdk_10_0
        ];
    in
    {
      options.modules.langs.dotnet = {
        enable = lib.mkEnableOption "dotnet";
      };

      config = lib.mkIf cfg.enable {
        home = {
          sessionVariables = {
            DOTNET_CLI_TELEMETRY_OPTOUT = "true";
          };
          packages = [ dotnet-sdks ];
        };

        programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
          ms-dotnettools.csharp
        ];
      };
    };

  nixpkgs.allowedUnfreePackages = [
    "vscode-extension-ms-dotnettools-csharp"
  ];
}
