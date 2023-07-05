{ lib
, stdenv
, fetchFromGitHub
, maven
, makeWrapper
, jre
, libXtst
, wrapGAppsHook
}:
let
  pname = "quark-goldleaf";
  version = "0.10.1";

  goldleafSrc = fetchFromGitHub {
    owner = "XorTroll";
    repo = "Goldleaf";
    rev = "refs/tags/${version}";
    sha256 = "sha256-Kq9IkkPJgPCdTBWlpqz2AexYqp6auFnsy/hV/n980VQ=";
  };

  quarkUnwrapped = maven.buildMavenPackage {
    pname = "${pname}-unwrapped";
    inherit version;

    src = goldleafSrc + "/Quark";
    mvnHash = "sha256-eqe2NqtCC6aJg5kptKqd0wUlM7/FHDsEH48H1RHGzT0=";

    nativeBuildInputs = [
      makeWrapper
      maven
      wrapGAppsHook
    ];

    installPhase = ''
      install -D target/Quark.jar $out/share/java/${pname}.jar
      makeWrapper ${jre}/bin/java $out/bin/${pname} \
            --add-flags "-jar $out/share/java/${pname}.jar" \
            --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [libXtst]}"
    '';
  };
in
stdenv.mkDerivation {
  inherit pname version;
  nativeBuildInputs = [ makeWrapper ];
  phases = "installPhase";
  installPhase = ''
    makeWrapper ${quarkUnwrapped}/bin/${pname} $out/bin/${pname} \
          --append-flags "-cfgfile ~/quark.cfg"
  '';
  meta = with lib; {
    homepage = "https://github.com/XorTroll/Goldleaf/blob/master/Quark.md";
    description = "A PC tool made in Java with a fancy UI to help Goldleaf with remote file-transfer";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.tomasajt ];
  };
}
