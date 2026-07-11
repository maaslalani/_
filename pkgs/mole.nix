{
  lib,
  fetchFromGitHub,
  fetchurl,
  stdenvNoCC,
}: let
  pname = "mole";
  version = "1.44.1";

  releases = {
    aarch64-darwin = {
      arch = "arm64";
      hash = "sha256-9Geg6dMHi1QBITbgHdbfiu/tswrgfrMyD4faZna7B3Y=";
    };
    x86_64-darwin = {
      arch = "amd64";
      hash = "sha256-UifQ1kGwE2hXvZsyTH4zj1rkY9cjsR0s7sxe6kfnZKI=";
    };
  };

  system = stdenvNoCC.hostPlatform.system;
  release =
    releases.${system}
      or (throw "mole is only packaged for Darwin systems, but ${system} was requested");
  binaries = fetchurl {
    url = "https://github.com/tw93/Mole/releases/download/V${version}/binaries-darwin-${release.arch}.tar.gz";
    inherit (release) hash;
  };
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "tw93";
      repo = "Mole";
      tag = "V${version}";
      hash = "sha256-cQK8RMp0tdAnz56tTldjw2lFa4LHXoXMNWIL8IHfo7w=";
    };

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/bin" "$out/libexec/mole"
      cp -R bin lib "$out/libexec/mole/"
      cp mole mo "$out/bin/"
      chmod +x "$out/bin/mole" "$out/bin/mo" "$out/libexec/mole/bin/"*.sh

      substituteInPlace "$out/bin/mole" \
        --replace-fail \
        'SCRIPT_DIR="$(cd "$(dirname "''${BASH_SOURCE[0]}")" && pwd)"' \
        "SCRIPT_DIR=\"$out/libexec/mole\""

      tar -xzf ${binaries} -C "$out/libexec/mole/bin"
      mv "$out/libexec/mole/bin/analyze-darwin-${release.arch}" "$out/libexec/mole/bin/analyze-go"
      mv "$out/libexec/mole/bin/status-darwin-${release.arch}" "$out/libexec/mole/bin/status-go"
      chmod +x "$out/libexec/mole/bin/analyze-go" "$out/libexec/mole/bin/status-go"

      runHook postInstall
    '';

    meta = {
      description = "Deep clean and optimize your Mac";
      homepage = "https://github.com/tw93/Mole";
      license = lib.licenses.gpl3Only;
      mainProgram = "mo";
      platforms = builtins.attrNames releases;
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
      maintainers = [];
    };
  }
