let
  pkgs = import <nixpkgs>;
in
{ stdenv ? pkgs.stdenv
, fetchFromGithub ? pkgs.fetchFromGithub
}:
stdenv.mkDerivation {
  pname = "distro-grub-themes";
  version = "3.1";
  src = fetchFromGitHub {
    owner = "AdisonCavani";
    repo = "distro-grub-themes";
    rev = "v3.1";
    hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
  };
  installPhase = "cp -r customize/nixos $out";
}
