{
  lib,
  writeShellApplication,
  bun,
}:

writeShellApplication {
  name = "tuistory";
  runtimeInputs = [bun];
  text = ''
    exec bunx --bun tuistory@0.10.0 "$@"
  '';

  meta = {
    description = "Run dev servers and TUIs that AI agents can read, wait on, and type into";
    homepage = "https://github.com/remorses/tuistory";
    license = lib.licenses.mit;
    maintainers = [];
    mainProgram = "tuistory";
  };
}
