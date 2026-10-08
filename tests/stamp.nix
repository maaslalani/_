let
  pkgs = (builtins.getFlake (toString ../.)).inputs.nixpkgs.legacyPackages.aarch64-darwin;
  module = import ../modules/stamp.nix {
    identity.github = "test-user";
    inherit (pkgs) lib;
    pkgs =
      pkgs
      // {
        gh = pkgs.writeShellScriptBin "gh" ''
          printf '%s\n' "$@" >> "$GH_CALLS"
          if [[ "$1 $2" == "pr view" ]]; then
            [[ "''${*: -1}" == "$EXPECTED_PR" ]] || exit 3
            if [[ "$GH_FAIL" == 1 ]]; then
              printf 'Cannot view %s\n' "$EXPECTED_PR" >&2
              exit 7
            fi
            printf '%s\n' "$APPROVED" PR_test 'example/repo#42: Example'
          elif [[ "$1 $2" == "api graphql" ]]; then
            printf '{}\n'
          else
            exit 4
          fi
        '';
        terminal-notifier = pkgs.writeShellScriptBin "terminal-notifier" ''
          printf '%s\n' "$@" > "$NOTIFICATION"
        '';
      };
  };
  stamp = builtins.head module.home.packages;
  workflow = module.home.file."Library/Services/Stamp.workflow".source;
in
  pkgs.runCommand "stamp-tests" {nativeBuildInputs = [pkgs.python3];} ''
    python3 - <<'PY'
    import os
    import pathlib
    import plistlib
    import shlex
    import subprocess
    import tempfile
    import time

    with open("${workflow}/Contents/document.wflow", "rb") as file:
        document = plistlib.load(file)
    command = document["actions"][0]["action"]["ActionParameters"]["COMMAND_STRING"]
    service = shlex.split(command)[1]
    canonical = "https://github.com/example/repo/pull/42"

    def run(executable, args, expected=canonical, code=0, approved="true", fail="0"):
        with tempfile.TemporaryDirectory() as directory:
            calls = pathlib.Path(directory, "calls")
            notification = pathlib.Path(directory, "notification")
            env = dict(os.environ, GH_CALLS=str(calls), NOTIFICATION=str(notification),
                       EXPECTED_PR=expected, APPROVED=approved, GH_FAIL=fail)
            result = subprocess.run([executable, *args], env=env, text=True, capture_output=True)
            assert result.returncode == code, (args, result.returncode, result.stderr)
            for _ in range(200):
                if notification.exists() and notification.read_text():
                    break
                time.sleep(0.01)
            message = notification.read_text()
            recorded = calls.read_text() if calls.exists() else ""
            assert "review.invalid" not in recorded + message + result.stdout + result.stderr
            if code == 2:
                assert not recorded
            elif code == 0:
                assert ("Already approved" if approved == "true" else "Stamped") in message
                assert ("api\ngraphql" in recorded) == (approved == "false")
            return recorded

    for executable in ["${stamp}/bin/stamp", service]:
        run(executable, ["https://review.invalid/review/example/repo/pull/42"])
        for link in [canonical, "github.com/example/repo/pull/42",
                     "https://review.invalid/review/example/repo/pull/42"]:
            for suffix in ["", "/files", "?tab=files#diff-123"]:
                run(executable, [" \t" + link + suffix + "\n"])
        run(executable, ["https://review.invalid/review/example/repo/pull/42"], approved="false")
        run(executable, ["https://review.invalid/review/example/repo/pull/42"], code=7, fail="1")
        for invalid in ["https://review.invalid/review/example/repo/pull/0",
                        "https://review.invalid/review/example/repo/pull/nope",
                        "https://review.invalid/review/example/repo/pull/42 extra",
                        "https://review.invalid/review/example/repo/pull/42\n" + canonical,
                        "https://review.invalid/other/example/repo/pull/42",
                        "http://review.invalid/review/example/repo/pull/42"]:
            run(executable, [invalid], code=2)
        run(executable, [canonical, canonical], code=2)
    for identifier in ["42", "feature/topic"]:
        run("${stamp}/bin/stamp", [identifier], expected=identifier)
        run(service, [identifier], code=2)
    run("${stamp}/bin/stamp", [], expected="--")
    run(service, [], code=2)
    print("Stamp CLI/service normalization, privacy, approval, and rejection checks passed.")
    PY
    touch "$out"
  ''
