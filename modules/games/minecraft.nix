{
  flake.modules.homeManager.games =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [ prismlauncher ];

      programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
        SPGoding.datapack-language-server
        arcensoth.language-mcfunction
      ];
    };
}
