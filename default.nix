{ mkDerivation, base, csv, stdenv, time }:
mkDerivation {
  pname = "story-lifecycle-report";
  version = "0.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base csv time ];
  license = stdenv.lib.licenses.gpl3;
}
