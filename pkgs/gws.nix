{
  lib,
  rustPlatform,
  pkg-config,
  dbus,
  apple-sdk_14,
  darwinMinVersionHook,
  fetchFromGitHub,
  stdenv,
}:
rustPlatform.buildRustPackage {
  pname = "gws";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "googleworkspace";
    repo = "cli";
    rev = "v0.4.1";
    hash = "sha256-Ar21dUPuHoJY+z1I80ckT5EcIrpGrmMpi2VAXpBSDwA=";
  };

  cargoHash = "sha256-zmFQEtDisZ7lpgiMv0X6F3R/j/1SHw9vmWA3qnauO0Y=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    lib.optionals stdenv.hostPlatform.isLinux [
      dbus
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      apple-sdk_14
      (darwinMinVersionHook "10.15")
    ];

  doCheck = false;

  meta = {
    description = "Google Workspace CLI — one command-line tool for Drive, Gmail, Calendar, Sheets, Docs, Chat, Admin, and more";
    homepage = "https://github.com/googleworkspace/cli";
    license = lib.licenses.asl20;
    maintainers = [];
    mainProgram = "gws";
  };
}
