{ pkgs, ... }:
with builtins; {
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

    ${(import ./prompt.nix).precmd}
  '';
  sessionVariables = import ./env.nix;
  plugins = [
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "1715f39a4680a27abd57fc30c98a95fdf191be45";
        sha256 = "1kpxima0fnypl7fak4snxnf6nj36nvp1gqwpx1ailyrgxa8641j0";
      };
    }
  ];
}
