{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.bash;
in

{
  options.modules.bash = {
    enable = lib.mkEnableOption "bash";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        snrs = "sudo nixos-rebuild switch";
        ls = "ls --group-directories-first --color=auto";
        code = "codium";
        sdn = "shutdown now";
        nv = "nvim";
      };
      initExtra = ''
        export PS1="\[\033[1;32m\]\w \$ \[\033[0m\]"
      '';
    };
  };
}


  
