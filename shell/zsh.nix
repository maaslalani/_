{ pkgs, ... }:
with builtins;
let
  prompt = import ./prompt.nix;
in {
  autocd = true;
  dotDir = ".config/zsh";
  enable = true;
  shellAliases = import ./aliases.nix;
  defaultKeymap = "viins";
  initExtraBeforeCompInit = ''
    fpath+="$HOME/.nix-profile/share/zsh/site-functions"
    fpath+="$HOME/.nix-profile/share/zsh/5.8/functions"

    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  '';
  initExtra = ''
    setopt prompt_subst

    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^?' backward-delete-char
    bindkey '^[[Z' reverse-menu-complete

    source /opt/dev/dev.sh

    ${prompt.precmd}
  '';
  sessionVariables = import ./env.nix;
  plugins = [
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "932e29a0c75411cb618f02995b66c0a4a25699bc";
        sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
      };
    }
  ];
}
