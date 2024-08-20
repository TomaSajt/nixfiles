{ pkgs, lib, ... }:
{

  environment.loginShellInit = "fbterm";

  security.wrappers.fbterm = {
    source = "${pkgs.fbterm}/bin/fbterm";
    owner = "nobody";
    group = "nogroup";
    capabilities = "cap_sys_tty_config+ep";
  };

  home-manager.users.toma = {
    # https://github.com/nyarla/nixos-configurations/blob/8edd7435a5c37d61180570b927e7d023e7a0989d/dotfiles/config/shell/fbterm.nix#L4
    xdg.configFile."fbterm/fbtermrc".text = lib.generators.toKeyValue { } {
      font-names = "monospace";
      font-size = 18;

      color-0 = "000000";
      color-1 = "ff6633";
      color-2 = "ccff00";
      color-3 = "ffcc33";
      color-4 = "00ccff";
      color-5 = "cc99cc";
      color-6 = "00cccc";
      color-7 = "ffffff";

      color-8 = "333333";
      color-9 = "ff6633";
      color-10 = "ccff00";
      color-11 = "ffcc33";
      color-12 = "00ccff";
      color-13 = "cc99cc";
      color-14 = "00cccc";
      color-15 = "ffffff";

      color-foreground = 7;
      color-background = 0;

      history-lines = 1000;

      text-encodings = "UTF-8";

      cursor-shape = 0;
      cursor-interval = 500;

      word-chars = "._-";

      screen-rotate = 0;

      ambiguous-wide = "no";
    };
  };

}
