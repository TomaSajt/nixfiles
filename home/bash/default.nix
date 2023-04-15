{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    shellAliases = {
      snrs = "sudo nixos-rebuild switch";
      ll = "ls -la";
      code = "codium";
      sdn = "shutdown now";
      nv = "nvim";
    };
    sessionVariables = {
      PS1=''\[\033[1;32m\]\w \$ \[\033[0m\]'';
    };
  };
}
