{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.i3;
in
{
  options.modules.i3.autorandr = {
    enable = lib.mkEnableOption "autorandr";
  };
  config = lib.mkIf (cfg.enable && cfg.autorandr.enable) {
    services.autorandr.enable = true;
    programs.autorandr = {
      enable = true;
      profiles = {
        "desktop-home" = {
          fingerprint = {
            "HDMI-0" = "00ffffffffffff004c2d4c0c46584d30101b0103803d23782a5fb1a2574fa2280f5054bfef80714f810081c081809500a9c0b300010108e80030f2705a80b0588a0060592100001e000000fd00184b1e873c000a202020202020000000fc00553238453539300a2020202020000000ff004854504a3430363535330a20200140020334f04d611203130420221f105f605d5e23090707830100006d030c002000803c20106001020367d85dc401788003e30f0104023a801871382d40582c450060592100001e023a80d072382d40102c458060592100001e011d007251d01e206e28550060592100001e565e00a0a0a029503020350060592100001a00000074";
          };
          config = {
            "HDMI-0" = {
              enable = true;
              primary = true;
              crtc = 0;
              position = "0x0";
              mode = "3840x2160";
            };
          };
        };
        "thinkpad-school" = {
          fingerprint = {
            "eDP-1" = "00ffffffffffff000daee715000000002c1e0104a52213780228659759548e271e505400000001010101010101010101010101010101363680a0703820403020350058c110000018000000fe004e3135364843412d4541420a20000000fe00434d4e0a202020202020202020000000fe004e3135364843412d4541420a20004e";
          };
          config = {
            "eDP-1" = {
              enable = true;
              primary = true;
              crtc = 0;
              position = "0x0";
              mode = "1920x1080";
            };
          };
        };
        "thinkpad-school-on-home-tv" = {
          fingerprint = {
            "HDMI-1" = "00ffffffffffff001e6d010001010101011c010380a05a780aee91a3544c99260f5054a108003140454061407140818001010101010108e80030f2705a80b0588a0040846300001e023a801871382d40582c450040846300001e000000fd003a791e883c000a202020202020000000fc004c472054560a202020202020200162020363f15a6160101f66650413051403021220212215015d5e5f6263643f40320957071507505707016704033d1ec05f7e016e030c002000b83c2000800102030467d85dc401788003e200cfe305c000e3060d01e20f33eb0146d000260c19458a5ea3662150b051001b304070360040846300001e00000000000000000000cf";
            "eDP-1" = "00ffffffffffff000daee715000000002c1e0104a52213780228659759548e271e505400000001010101010101010101010101010101363680a0703820403020350058c110000018000000fe004e3135364843412d4541420a20000000fe00434d4e0a202020202020202020000000fe004e3135364843412d4541420a20004e";
          };
          config = {
            "eDP-1" = {
              enable = true;
              primary = true;
              crtc = 0;
              position = "0x0";
              mode = "1920x1080";
            };
            "HDMI-1" = {
              enable = true;
              primary = false;
              crtc = 1;
              position = "0x0";
              mode = "1920x1080";
              rate = "120.00";
            };
          };
        };
      };
      hooks.postswitch = {
        "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
      };
    };
  };
}
