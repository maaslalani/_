rec {
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
  KUBECONFIG =  builtins.concatStringsSep ":" [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
  MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  MATHMODELS = "$HOME/Documents/School/EECS3311/mathmodels";
  NIX_BIN = "$HOME/.nix-profile/bin";
  NIX_PATH = builtins.concatStringsSep ":" [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
  PASSWORD_STORE_DIR = "$HOME/.config/pass";
  PATH = builtins.concatStringsSep ":" [ CARGO_BIN EIFFEL_BIN GOBIN GOBO_BIN NIX_BIN "$PATH" ];
  PROMPT = (import ./prompt.nix).ps1;
  TERM = "xterm-256color";
}
