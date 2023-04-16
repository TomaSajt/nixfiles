{ pkgs, ... }: {
  programs.readline = {
    enable = true;
    bindings = {
      "\\t" = "menu-complete"; # Tab
      "\\e[Z" = "menu-complete-backward"; # Shift + Tab
      "\\e[1;5A" = "history-search-backward"; # Ctrl + Up
      "\\e[1;5B" = "history-search-forward"; # Ctrl + Down
      "\\e[1;5C" = "forward-word"; # Ctrl + Right
      "\\e[1;5D" = "backward-word"; # Ctrl + Left
    };
    extraConfig = ''
      set show-all-if-ambiguous on
      set completion-ignore-case on
      set menu-complete-display-prefix on
    '';
  };
}
