{
  flake.modules.homeManager.base =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.modules.git;
    in
    {
      options = {
        modules.git = {
          signing = lib.mkEnableOption "git GPG signing";
        };
      };

      config = {
        modules.git.signing = lib.mkDefault true;

        programs.git = {
          enable = true;
          package = pkgs.gitFull;
          signing = lib.mkIf cfg.signing {
            key = "F011163C050122A1";
            signByDefault = true;
          };
          settings = {
            user = {
              name = "TomaSajt";
              email = "62384384+TomaSajt@users.noreply.github.com";
            };
            github.user = "TomaSajt";
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            credential.helper = "${config.programs.git.package}/bin/git-credential-libsecret";
            pull.ff = "only";
            alias = {
              co = "checkout";
              br = "branch";
              ci = "commit";
              st = "status";
              last = "log -1 HEAD";
              uncommit = "reset --soft HEAD~";
            };
          };
        };

        programs.gh = {
          enable = true;
        };

        programs.vscode.profiles.default.userSettings = {
          "git.autofetch" = true;
          "git.enableSmartCommit" = true;
          "git.confirmSync" = false;
          "git.openRepositoryInParentFolders" = "always";
        };
      };
    };
}
