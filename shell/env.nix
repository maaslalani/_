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
  PATH = concatStringsSep ":" [
    "$HOME/.nix-profile/bin"
    "$HOME/.cargo/bin"
    "${GOPATH}/bin"
    "$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin"
    "$GOBO/../spec/$ISE_PLATFORM/bin"
    "/usr/local/bin"
    "/opt/local/bin"
    "$PATH"
  ];
  PROMPT = prompt.ps1;
  PASSWORD_STORE_DIR = "$HOME/.config/pass";
  TERM = "xterm-256color";
  MATHMODELS = "/Users/maas/mathmodels";
  ISE_PLATFORM = "macosx-x86-64";
  ISE_EIFFEL = "/Applications/MacPorts/Eiffel_19.05";
  GOBO = "$ISE_EIFFEL/library/gobo/svn";
}
