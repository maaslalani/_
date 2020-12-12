let
  pathJoin = builtins.concatStringsSep ":";
in rec {
  CARGO_BIN = "$HOME/.cargo/bin";
  CLICOLOR = 1;
  COLORTERM = "truecolor";
  EDITOR = "nvim";
  GOBIN = "${GOPATH}/bin";
  GOPATH = "$HOME/.config/go";
  KEYTIMEOUT = 1;
  KUBECONFIG =  pathJoin [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
  MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  NIX_BIN = "$HOME/.nix-profile/bin";
  NIX_PATH = pathJoin [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
  PASSWORD_STORE_DIR = "$HOME/.config/pass";
  PATH = pathJoin [ CARGO_BIN GOBIN NIX_BIN "$PATH" ];
  PROMPT = (import ./prompt.nix).ps1;
  TERM = "xterm-256color";
}
