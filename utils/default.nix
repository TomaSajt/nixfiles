{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
let

  mkStats =
    packageList:
    let
      packages = builtins.map (p: "${p.name}") packageList;
      sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;

  # Source: https://faq.i3wm.org/question/2172/how-do-i-find-the-criteria-for-use-with-i3-config-commands-like-for_window-eg-to-force-splashscreens-and-dialogs-to-show-in-floating-mode.1.html
  i3-window-info = pkgs.writeShellScriptBin "i3-window-info" ''
    match_int='[0-9][0-9]*'
    match_string='".*"'
    match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference
    {
        # Run xwininfo, get window id
        window_id=`${lib.getExe pkgs.xorg.xwininfo} -int | sed -nre "s/^xwininfo: Window id: ($match_int) .*$/\1/p"`
        echo "id=$window_id"

        # Run xprop, transform its output into i3 criteria. Handle fallback to
        # WM_NAME when _NET_WM_NAME isn't set
        ${lib.getExe pkgs.xorg.xprop} -id $window_id |
            sed -nr \
                -e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
                -e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
                -e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
                -e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}"
    } | sort | tr "\n" " " | sed -r 's/^(.*) $/[\1]\n/'
  '';
in
{
  home = {
    packages = [ i3-window-info ];

    file = {
      ".nix-debug/system-packages".text = mkStats osConfig.environment.systemPackages;
      ".nix-debug/home-packages".text = mkStats config.home.packages;
    };
  };
}
