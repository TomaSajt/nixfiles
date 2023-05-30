{ ... }:
{
  xdg.mimeApps = {
    enable = true;
    associations.added = { };
    # check /etc/profiles/per-user/toma/share/applications/mimeinfo.cache for associations used by the system already
    defaultApplications = {
      "application/pdf" = [ "firefox.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "inode/directory" = [ "thunar.desktop" ];
    };
  };
}
