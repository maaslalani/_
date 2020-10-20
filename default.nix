with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "_";
  buildInputs = [
    (import ./pkgs.nix { inherit pkgs; })
  ];
}
