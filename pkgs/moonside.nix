{
  lib,
  python3,
  fetchFromGitHub,
  makeWrapper,
  stdenvNoCC,
}: let
  pythonEnv = python3.withPackages (ps: [ps.bleak]);
in
  stdenvNoCC.mkDerivation {
    pname = "moonside";
    version = "0.1.0";

    src = fetchFromGitHub {
      owner = "bobek-balinek";
      repo = "claude-lamp";
      rev = "e13987d3013ffe98ae69aa51adc488c480cec467";
      hash = "sha256-KOOOoTwZc1fBYU2I26/cJ5ixcB3dAwjwBfRWMheQCq4=";
    };

    nativeBuildInputs = [makeWrapper];

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/moonside

      cp claude_hooks/moonside_daemon.py $out/share/moonside/
      substituteInPlace $out/share/moonside/moonside_daemon.py \
        --replace-fail "#!/usr/bin/env python3" "#!${pythonEnv}/bin/python3"
      chmod +x $out/share/moonside/moonside_daemon.py

      cp claude_hooks/moonside_hook.sh $out/share/moonside/
      chmod +x $out/share/moonside/moonside_hook.sh

      makeWrapper $out/share/moonside/moonside_hook.sh $out/bin/moonside \
        --prefix PATH : "${pythonEnv}/bin"

      runHook postInstall
    '';

    meta = {
      description = "Control your Moonside LED lamp via BLE based on Claude Code's state";
      homepage = "https://github.com/bobek-balinek/claude-lamp";
      license = lib.licenses.mit;
      maintainers = [];
      mainProgram = "moonside";
    };
  }
