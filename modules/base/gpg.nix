{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.gpg = {
        enable = true;
      };
      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-curses;
      };
    };
}
