{ stdenv
, lib

, fetchurl
, autoPatchelfHook
, dpkg

, ncurses5
, alsaLib
, atk
, cups
, glib
, gtk2
, nss_latest
, pango
, unixODBC
, xorg
}:
let
  version = "18.2";
  longVersion = "${version}.45405";
in
stdenv.mkDerivation
{
  pname = "dyalog-apl";
  inherit version;

  system = "x86_64-linux";

  src = fetchurl {
    url = "https://download.dyalog.com/download.php?file=18.2/linux_64_${longVersion}_unicode.x86_64.deb";
    sha256 = "pA/WGTA6YvwG4MgqbiPBLKSKPtLGQM7BzK6Bmyz5pmM=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    dpkg

    alsaLib
    atk
    cups
    ncurses5
    glib
    gtk2
    nss_latest
    pango
    unixODBC

    xorg.libX11
    xorg.libXdamage
    xorg.libXScrnSaver
    xorg.libXtst

  ];

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    mkdir $out/share $out/bin
    cp -av $out/opt/mdyalog/${version}/64/unicode/* $out/share
    rm -rf $out/opt $out/usr
    chmod -R g-w $out/share

    ln -s $out/share/mapl $out/bin/mapl
    ln -s $out/share/dyalog $out/bin/dyalog
  '';

  meta = with lib; {
    description = "Dyalog APL";
    homepage = "https://www.dyalog.com";
    license = licenses.unfree;
    maintainers = with maintainers; [ tomasajt ];
    platforms = [ "x86_64-linux" ];
  };
}
