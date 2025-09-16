{
  flake.modules.homeManager.graphical =

    { lib, config, ... }:
    let
      cfg = config.modules.mime-apps;

      strListOrSingleton = with lib.types; coercedTo (either (listOf str) str) lib.toList (listOf str);
    in
    # check /etc/profiles/per-user/toma/share/applications/mimeinfo.cache for associations used by the system already
    {
      options.modules.mime-apps = {
        enable = lib.mkEnableOption "mime-apps";
        associations = lib.mkOption {
          type = lib.types.attrsOf strListOrSingleton;
          default = { };
        };
      };

      config = {
        xdg.mimeApps = {
          enable = true;
          associations.added = cfg.associations;
          defaultApplications = cfg.associations;
        };
      };
    };
}
