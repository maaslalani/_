{ config, pkgs, lib, ... }:
let
  color = color: text: "%F{${color}}${text}%f";
in
{
  programs.zsh = {
    autocd = true;
    dotDir = ".config/zsh";
    enable = true;
    shellAliases = rec {
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      _ = "cd ~/_";

      dstroy = "fd -H .DS_Store | xargs sudo rm";

      g = "git";
      ga = "git add";
      gap = "${ga} --patch";
      gb = "git branch";
      gbc = "${gb} --show-current";
      gc = "git commit";
      gcam = "${gc} -am";
      gcm = "${gc} -m";
      gca = "${gc} --amend";
      gco = "git checkout";
      gcom = "${gco} master";
      gcp = "git cherry-pick";
      gcpa = "${gcp} --abort";
      gd = "git diff";
      gdm = "${gd} master";
      gl = "git pull";
      glo = "git log";
      gm = "git merge";
      gma = "${gm} --abort";
      gp = "git push";
      gpf = "${gp} --force-with-lease";
      gpsup = "${gp} --set-upstream origin `${gbc}`";
      gpos = "${gp} origin +@:staging";
      grb = "git rebase";
      grba = "${grb} --abort";
      grbc = "${grb} --continue";
      grbi = "${grb} --interactive";
      grbm = "${grb} master";
      gr = "git reset";
      grh = "${gr} --hard";
      grs = "git restore";
      gs = "${gss} --short";
      gss = "git status";
      gst = "git stash";
      gstp = "${gst} pop";
      gsw = "git switch";
      gswm = "${gsw} master";

      hmg = "nix build --out-link ~/.config/nixpkgs/result --impure --experimental-features 'nix-command flakes' '/Users/maas/_#home'";
      hms = "nix-shell -p nixUnstable --command \"${hmg}\" && ~/.config/nixpkgs/result/activate";

      ls = "exa";
      lsa = "exa -Fla";

      md = "mkdir";

      sz = "source ~/.config/zsh/.zshrc";

      ncg = "nix-collect-garbage";

      ta = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tls = "tmux list-sessions";
      tns = "tmux new-session -s `basename $(pwd)`";

      vi = "nvim";
      v = "${vi} .";
      vim = "${vi}";

      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; vim $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      wiki = "cd ~/wiki && vim ~/wiki/index.md";
    };
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

      precmd() {
        if [ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
          GIT_BRANCH="($(git branch --show-current))"
          GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
        else
          unset GIT_BRANCH
          unset GIT_STATUS
        fi
      }
    '';
    sessionVariables = let
      pathJoin = builtins.concatStringsSep ":";
    in
      rec {
        CARGO_BIN = "$HOME/.cargo/bin";
        CLICOLOR = 1;
        COLORTERM = "truecolor";
        EDITOR = "nvim";
        GOBIN = "${GOPATH}/bin";
        GOPATH = "$HOME/.config/go";
        KEYTIMEOUT = 1;
        KUBECONFIG = pathJoin [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        NIX_BIN = "$HOME/.nix-profile/bin";
        NIX_PATH = pathJoin [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
        PASSWORD_STORE_DIR = "$HOME/.config/pass";
        PATH = pathJoin [ CARGO_BIN GOBIN NIX_BIN "$PATH" ];
        PROMPT = "${color "blue" "%2~"} ${color "magenta" "\\$GIT_BRANCH"} ${color "red" "\\$GIT_STATUS"} \n%(?.${color "green" "❯"}.${color "red" "❯"}) ";
        TERM = "xterm-256color";
      };
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
  };
}
