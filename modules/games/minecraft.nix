{
  flake.modules.homeManager.games =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [ prismlauncher ];

      programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
        SPGoding.datapack-language-server
        arcensoth.language-mcfunction
      ];
    };
}
