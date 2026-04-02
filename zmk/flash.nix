{
  writeShellScriptBin,
  coreutils,
  firmware,
}:
writeShellScriptBin "flash" ''
  set -e

  INFO="\033[0;34m[INFO]\033[0m"
  DONE="\033[0;32m[DONE]\033[0m"
  ERROR="\033[0;31m[ERROR]\033[0m"

  VOLUME="/Volumes/NICENANO"

  echo -e "$INFO Waiting for $VOLUME..."
  while [ ! -d "$VOLUME" ]; do sleep 1; done

  sleep 1

  echo -e "$INFO Flashing Firmware"
  ${coreutils}/bin/cp ${firmware}/zmk_left.uf2 "$VOLUME/" || {
    echo -e "$ERROR Failed to copy firmware"
    exit 1
  }
  echo -e "$DONE Firmware Loaded"
''
