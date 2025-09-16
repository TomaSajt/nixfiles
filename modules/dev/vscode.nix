{
  flake.modules.homeManager.dev =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.modules.vscode;
    in
    {
      options.modules.vscode = {
        enable = lib.mkEnableOption "vscode";
      };

      config = lib.mkIf cfg.enable {
        programs.vscode = {
          enable = true;
          package = pkgs.vscodium;

          profiles.default = {
            extensions = with pkgs.vscode-extensions; [ pkief.material-icon-theme ];

            userSettings = {
              "workbench.iconTheme" = "material-icon-theme";
            };
          };
        };
      };
    };
}
