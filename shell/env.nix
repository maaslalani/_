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
    "/usr/local/bin"
    "$PATH"
  ];
  FPATH = concatStringsSep ":" [
    "$HOME/.nix-profile/share/zsh/site-functions"
    "$FPATH"
  ];
  PROMPT = prompt.ps1;
  PASSWORD_STORE_DIR = "$HOME/.config/pass";
  TERM = "xterm-256color";
}
