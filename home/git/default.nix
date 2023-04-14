{ pkgs, config, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Toma";
    userEmail = "62384384+TomaSajt@users.noreply.github.com";
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
}
