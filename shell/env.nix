let
  prompt = import ./prompt.nix;
  combine = concatStringSep ":";
in with builtins; rec {
  CARGO_BIN = "$HOME/.cargo/bin";
  CLICOLOR = 1;
  EDITOR = "nvim";
  EIFFEL_BIN = "$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin";
  GOBIN = "${GOPATH}/bin";
  GOBO = "$ISE_EIFFEL/library/gobo/svn";
  GOBO_BIN = "$GOBO/../spec/$ISE_PLATFORM/bin";
  GOPATH = "$HOME/.config/go";
  ISE_EIFFEL = "/Applications/MacPorts/Eiffel_19.05";
  ISE_PLATFORM = "macosx-x86-64";
  KEYTIMEOUT = 1;
  KUBECONFIG =  combine [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
  MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  MATHMODELS = "/Users/maas/Documents/School/EECS3311/mathmodels";
  NIX_BIN = "$HOME/.nix-profile/bin";
  NIX_PATH = combine [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
  PASSWORD_STORE_DIR = "$HOME/.config/pass";
  PATH = combine [ CARGO_BIN GOBIN NIX_BIN EIFFEL_BIN GOBO_BIN "$PATH" ];
  PROMPT = prompt.ps1;
  TERM = "xterm-256color";
}
