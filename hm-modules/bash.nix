{ pkgs, lib, config, ... }:
let
  cfg = config.modules.bash;
in
{
  options.modules.bash = {
    enable = lib.mkEnableOption "bash";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        snrs = "sudo nixos-rebuild switch";
        ls = "ls --group-directories-first --color=auto";
        code = "codium";
        sdn = "shutdown now";
        nv = "nvim";
        nix-gcroots = "ls -l $(readlink /nix/var/nix/gcroots/auto/*)";
        "えんヴぃむ" = "nvim";
        "ばっしゅ" = "bash";
      };
      initExtra = ''
        export PS1="\[\033[1;32m\]\w \$ \[\033[0m\]"
      '';
    };

    programs.readline = {
      enable = true;
      bindings = {
        # Press Ctrl+V then the keybinding in the shell to see what's the escape sequence (idk)
        "\\t" = "menu-complete"; # Tab
        "\\e[Z" = "menu-complete-backward"; # Shift + Tab
        "\\e[1;5A" = "history-search-backward"; # Ctrl + Up
        "\\e[1;5B" = "history-search-forward"; # Ctrl + Down
        "\\e[1;5C" = "forward-word"; # Ctrl + Right
        "\\e[1;5D" = "backward-word"; # Ctrl + Left
        "\\C-h" = "backward-kill-word"; # Ctrl + Backspace (the other direction works by default)
      };
      extraConfig = ''
        set show-all-if-ambiguous on
        set completion-ignore-case on
        set menu-complete-display-prefix on
      '';
    };
  };
}
