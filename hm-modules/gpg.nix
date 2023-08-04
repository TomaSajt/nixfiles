{ config, lib, ... }:
let
  cfg = config.modules.gpg;
in
{
  options.modules.gpg = {
    enable = lib.mkEnableOption "GPG";
  };

  config = lib.mkIf cfg.enable {
    programs.gpg = {
      enable = true;
    };
    services.gpg-agent = {
      enable = true;
    };
  };
}
