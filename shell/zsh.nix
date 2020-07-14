{ pkgs, ... }:
with builtins;
let
  prompt = import ./prompt.nix;
in {
  autocd           = true;
  dotDir           = ".config/zsh";
  enable           = true;
  enableCompletion = true;
  shellAliases     = import ./aliases.nix;
  defaultKeymap    = "viins";
  initExtra        = ''
    setopt prompt_subst

    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^?' backward-delete-char
    bindkey '^[[Z' reverse-menu-complete

    dev() {
      source /opt/dev/dev.sh
      dev $@
    }

    ${prompt.precmd}
  '';
  sessionVariables = {
    CLICOLOR   = 1;
    EDITOR     = "nvim";
    KEYTIMEOUT = 1;
    MANPAGER   = "sh -c 'col -bx | bat -l man -p'";
    PROMPT     = prompt.ps1;
    TERM       = "xterm-256color";

    KUBECONFIG = concatStringsSep ":" [
      "$HOME/.kube/config"
      "$HOME/.kube/config.shopify.cloudplatform"
    ];
    NIX_PATH = concatStringsSep ":" [
      "$NIX_PATH"
      "$HOME/.nix-defexpr/channels"
    ];
    PATH = concatStringsSep ":" [
      "$HOME/.nix-profile/bin"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
      "/usr/local/bin"
      "$PATH"
    ];

    PASSWORD_STORE_DIR = "$HOME/.config/pass";
  };
  plugins = [
    {
      name = "zsh-syntax-highlighting";
      src  = pkgs.fetchFromGitHub {
        owner  = "zsh-users";
        repo   = "zsh-syntax-highlighting";
        rev    = "932e29a0c75411cb618f02995b66c0a4a25699bc";
        sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
      };
    }
  ];
}
