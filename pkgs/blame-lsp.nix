# published npm tarballs, flat node_modules; upstream's lockfile is
# pnpm-shaped so buildNpmPackage can't install from it, and the blame-lsp
# tarball ships prebuilt dist/ so no build step is needed
{
  fetchurl,
  lib,
  makeBinaryWrapper,
  nodejs,
  runCommand,
}: let
  version = "0.1.3";
  npmTar = name: version: hash:
    fetchurl {
      url = "https://registry.npmjs.org/${name}/-/${name}-${version}.tgz";
      inherit hash;
    };
  packages = {
    blame-lsp = npmTar "blame-lsp" version "sha256-jTNVStlZbnYDcLsyLQ11wyU/q02sYcuScniS3Tbpy7A=";
    vscode-jsonrpc = npmTar "vscode-jsonrpc" "8.2.0" "sha256-PaRFMcOY8VRQdMtyjjWagi81ufiscXHIR/QvByi5x8s=";
    vscode-languageserver = npmTar "vscode-languageserver" "9.0.1" "sha256-bNf0Y654cuWIpN1e1RSUdf4y5TUXUJqB5xXrBUBgJBI=";
    vscode-languageserver-protocol = npmTar "vscode-languageserver-protocol" "3.17.5" "sha256-dHPrLSFj8/i+oJZE+dgDeJoZXllrZdOUbEFX5YPjzMg=";
    vscode-languageserver-textdocument = npmTar "vscode-languageserver-textdocument" "1.0.12" "sha256-nx0ogU1u6BJn9S9byMkgu2oKI+tt5IlgNFoKJfvzsNs=";
    vscode-languageserver-types = npmTar "vscode-languageserver-types" "3.17.5" "sha256-1nP55/i75RNRvlHFjzLU3PqXpnDruGvGMzaDlMYJysA=";
  };
in
  runCommand "blame-lsp-${version}" {nativeBuildInputs = [makeBinaryWrapper];} ''
    ${lib.concatStrings (lib.mapAttrsToList (name: src: ''
        mkdir -p $out/lib/node_modules/${name}
        tar xzf ${src} --strip-components=1 -C $out/lib/node_modules/${name}
      '')
      packages)}
    makeWrapper ${lib.getExe nodejs} $out/bin/blame-lsp \
      --add-flags $out/lib/node_modules/blame-lsp/dist/server.js
  ''
