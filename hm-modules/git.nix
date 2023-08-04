{ pkgs, lib, config, ... }:
let
  cfg = config.modules.git;
in
{
  options = {
    modules.git = {
      enable = lib.mkEnableOption "git";
      signing = lib.mkEnableOption "git GPG signing";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
      userName = "TomaSajt";
      userEmail = "62384384+TomaSajt@users.noreply.github.com";
      signing = lib.mkIf cfg.signing {
        key = "F011163C050122A1";
        signByDefault = true;
      };
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        last = "log -1 HEAD";
        uncommit = "reset --soft HEAD~";
      };
      extraConfig = {
        github.user = "TomaSajt";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        credential.helper = "${config.programs.git.package}/bin/git-credential-libsecret";
        pull.ff = "only";
      };
    };

    programs.gh = {
      enable = true;
    };
  };
}
