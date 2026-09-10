{
  flake.modules.homeManager.dev =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    let
      cfg = config.modules.langs.java;

      jdk = pkgs.jdk;
    in
    {
      options.modules.langs.java = {
        enable = lib.mkEnableOption "java";
      };

      config = lib.mkIf cfg.enable {
        home = {
          packages = [
            jdk
            pkgs.maven
            pkgs.eclipses.eclipse-java
          ];
        };

        home.sessionVariables = {
          JAVA_HOME = "${jdk.home}";
        };

        programs.eclipse = {
          #enable = true;
        };

        programs.vscodium.profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            vscjava.vscode-java-pack
            redhat.java
            vscjava.vscode-java-debug
            vscjava.vscode-java-test
            vscjava.vscode-java-dependency
            vscjava.vscode-gradle
            vscjava.vscode-maven

            sonarsource.sonarlint-vscode
          ];

          userSettings = {
            "sonarlint.ls.javaHome" = "${jdk.home}/";
            "maven.executable.preferMavenWrapper" = false;
            "redhat.telemetry.enabled" = false;

          };
        };

      };
    };
}
