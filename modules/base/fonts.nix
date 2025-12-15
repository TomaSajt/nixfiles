{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {

      fonts = {
        fontDir.enable = true;

        fontconfig.defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
          monospace = [
            "JetBrainsMono Nerd Font"
            "Uiua386"
          ];

        };
        packages = with pkgs; [
          noto-fonts
          noto-fonts-color-emoji
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif

          nerd-fonts.jetbrains-mono
          uiua386

        ];
      };
    };
}
