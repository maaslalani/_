{ config, pkgs, lib, ... }:
let
  color = color: text: "%F{${color}}${text}%f";
  cyan = color "cyan";
  blue = color "blue";
  magenta = color "magenta";
  red = color "red";
  green = color "green";
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
      gca = "${gc} --amend";
      gcam = "${gc} -am";
      gcm = "${gc} -m";
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
      gpos = "${gp} origin +@:staging";
      gpsup = "${gp} --set-upstream origin `${gbc}`";
      gr = "git reset";
      grb = "git rebase";
      grba = "${grb} --abort";
      grbc = "${grb} --continue";
      grbi = "${grb} --interactive";
      grbm = "${grb} master";
      grev = "git rev-parse HEAD";
      grh = "${gr} --hard";
      grpo = "git remote prune origin";
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
      ns = " open https://search.nixos.org/packages\\?channel=unstable";

      ta = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tls = "tmux list-sessions";
      tns = "tmux new-session -s `basename $(pwd)`";
      tnvs = "tmux new -A -s default \"vim -S $VIM_SESSION_PATH; $SHELL\"";

      vi = "nvim";
      v = "${vi} .";
      vim = "${vi}";

      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; vim $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      wiki = "cd ~/wiki && vim ~/wiki/index.wiki && cd -";
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

      if [ -f /opt/dev/dev.sh ]; then
        source /opt/dev/dev.sh
      fi

      precmd() {
        if [ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
          GIT_BRANCH="($(git branch --show-current))"
          GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
        else
          unset GIT_BRANCH
          unset GIT_STATUS
        fi
      }

      if [ -z "$TMUX" ]; then
        tmux attach -t default || tmux new -s default
      fi
    '';
    sessionVariables = let
      pathJoin = builtins.concatStringsSep ":";
    in
      rec {
        BROWSER = "Brave Browser";
        CARGO_BIN = "$HOME/.cargo/bin";
        CLICOLOR = 1;
        COLORTERM = "truecolor";
        EDITOR = "nvim";
        GOBIN = "${GOPATH}/bin";
        GOPATH = "$HOME/.config/go";
        KEYTIMEOUT = 1;
        KUBECONFIG = pathJoin [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
        MANPAGER = "nvim +Man!";
        NIX_BIN = "$HOME/.nix-profile/bin";
        NIX_PATH = pathJoin [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
        PASSWORD_STORE_DIR = "$HOME/.config/pass";
        PATH = pathJoin [ CARGO_BIN GOBIN NIX_BIN "$PATH" ];
        PROMPT = "${cyan "\\$USER"}${blue "@\\$HOST"} ${blue "%3~"} ${magenta "\\$GIT_BRANCH"} ${red "\\$GIT_STATUS"} \n%(?.${green "❯"}.${red "❯"}) ";
        TERM = "xterm-256color";
        VIM_SESSION_PATH = "/tmp/session.vim";
      };
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "5eb494852ebb99cf5c2c2bffee6b74e6f1bf38d0";
          sha256 = "8gyZe6OPVLMdfruHJAHcyYeuiyvMTLvuX1UnUOv8eg8=";
        };
      }
    ];
  };
}
