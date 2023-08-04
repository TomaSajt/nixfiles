{ config, lib, ... }:
with lib;
let
  cfg = config.modules.gpg;
in
{
  options.modules.gpg = {
    enable = mkEnableOption "GPG";
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
    };
    services.gpg-agent = {
      enable = true;
    };
  };
}
