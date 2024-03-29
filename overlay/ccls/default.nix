{ lib
, stdenv
, fetchFromGitHub
, cmake
, llvmPackages
, rapidjson
, runtimeShell
}:

stdenv.mkDerivation rec {
  pname = "ccls";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "MaskRay";
    repo = "ccls";
    rev = "ee2d4f5b9a2181e2c71341d34c7d2463f0c28cd1";
    sha256 = "sha256-u499fHd2lyqOYXJApFdiIXHQGF+QEVlQ4E8jm5VMb3w=";
  };

  nativeBuildInputs = [ cmake llvmPackages.llvm.dev ];
  buildInputs = with llvmPackages; [ libclang llvm rapidjson ];

  cmakeFlags = [ "-DCCLS_VERSION=${version}" ];

  preConfigure = ''
    cmakeFlagsArray+=(-DCMAKE_CXX_FLAGS="-fvisibility=hidden -fno-rtti")
  '';

  clang = llvmPackages.clang;
  shell = runtimeShell;

  postFixup = ''
    export wrapped=".ccls-wrapped"
    mv $out/bin/ccls $out/bin/$wrapped
    substituteAll ${./wrapper} $out/bin/ccls
    chmod --reference=$out/bin/$wrapped $out/bin/ccls
  '';

  meta = with lib; {
    description = "A c/c++ language server powered by clang";
    homepage = "https://github.com/MaskRay/ccls";
    license = licenses.asl20;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ mic92 tobim ];
  };
}
