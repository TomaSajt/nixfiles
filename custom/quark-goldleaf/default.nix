
let
  pkgs = import <nixpkgs> {};
in
{ stdenv ? pkgs.stdenv
, fetchurl ? pkgs.fetchurl
, makeWrapper ? pkgs.makeWrapper
, jre ? pkgs.jre
, lib ? pkgs.lib
}:

stdenv.mkDerivation rec {
  name = "quark-goldleaf";
  version = "0.5";

  # Fetch the Quark JAR file from the Goldleaf GitHub repo
  src = fetchurl {
    url = "https://github.com/XorTroll/Goldleaf/releases/download/0.10/Quark.jar";
    sha256 = "c90693adbcd5c44b5b35f235ecbe9c230b1910ded47bf2de8eb44cf7d5c18d07";
  };
  # No need to unpack the JAR file
  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -pv $out/share/java $out/bin
    cp ${src} $out/share/java/${name}-${version}.jar
    makeWrapper ${jre}/bin/java $out/bin/${name} \
      --add-flags "-jar $out/share/java/${name}-${version}.jar -cfgfile \$HOME/.config/quark-goldleaf.cfg" \
  '';

  meta = with lib; {
    homepage = "https://github.com/XorTroll/Goldleaf/blob/master/Quark.md";
    description = "A PC tool made in Java with a fancy UI to help Goldleaf with remote file-transfer";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.tomasajt ];
  };
}

