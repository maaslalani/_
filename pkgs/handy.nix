{
  lib,
  fetchurl,
  makeWrapper,
  stdenvNoCC,
}: let
  pname = "handy";
  version = "0.7.10";

  releases = {
    aarch64-darwin = {
      url = "https://github.com/cjpais/Handy/releases/download/v0.7.10/Handy_aarch64.app.tar.gz";
      hash = "sha256-3exikuEMzPe1eZkIhU0tMrDVbeMLToSdbza2/9lqXyA=";
    };
    x86_64-darwin = {
      url = "https://github.com/cjpais/Handy/releases/download/v0.7.10/Handy_x64.app.tar.gz";
      hash = "sha256-Lao5a5yLatdrwKTPA9iDFpSKaeVn+OOKtsh18w3H02c=";
    };
  };

  system = stdenvNoCC.hostPlatform.system;
  release =
    releases.${system}
      or (throw "handy is only packaged for Darwin systems, but ${system} was requested");
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchurl {
      inherit (release) url hash;
    };

    sourceRoot = ".";
    nativeBuildInputs = [makeWrapper];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/Applications $out/bin
      cp -R Handy.app $out/Applications/

      makeWrapper \
        $out/Applications/Handy.app/Contents/MacOS/Handy \
        $out/bin/handy

      runHook postInstall
    '';

    meta = {
      description = "A free, open source, and extensible speech-to-text application that works completely offline";
      homepage = "https://github.com/cjpais/Handy";
      license = lib.licenses.mit;
      mainProgram = "handy";
      platforms = builtins.attrNames releases;
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
      maintainers = [];
    };
  }
