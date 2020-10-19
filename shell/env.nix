let
  prompt = import ./prompt.nix;
in with builtins; rec {
  EDITOR = "nvim";
  CLICOLOR = 1;
  KEYTIMEOUT = 1;
  KUBECONFIG = concatStringsSep ":" [
    "$HOME/.kube/config"
    "$HOME/.kube/config.shopify.cloudplatform"
  ];
  MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  NIX_PATH = concatStringsSep ":" [
    "$NIX_PATH"
    "$HOME/.nix-defexpr/channels"
  ];
  GOPATH = "$HOME/.config/go";
  GOBIN = "${GOPATH}/bin";
  CARGO_BIN = "$HOME/.cargo/bin";
  NIX_BIN = "$HOME/.nix-profile/bin";
  PATH = concatStringsSep ":" [
    "/nix/var/nix/gcroots/dev-profiles/user-extra-profile"
    NIX_BIN
    CARGO_BIN
    GOBIN
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/opt/local/bin"
    "/opt/dev/bin/user"
    "/opt/dev/bin"
    "$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin"
    "$GOBO/../spec/$ISE_PLATFORM/bin"
  ];
  PROMPT = prompt.ps1;
  PASSWORD_STORE_DIR = "$HOME/.config/pass";
  TERM = "xterm-256color";
  MATHMODELS = "/Users/maas/Documents/School/EECS3311/mathmodels";
  ISE_PLATFORM = "macosx-x86-64";
  ISE_EIFFEL = "/Applications/MacPorts/Eiffel_19.05";
  GOBO = "$ISE_EIFFEL/library/gobo/svn";
}
