{ config, pkgs, lib, ... }:
let
  color = color: text: "%F{${color}}${text}%f";
  cyan = color "cyan";
  blue = color "blue";
  magenta = color "magenta";
  red = color "red";
  green = color "green";

  flake = cmd: "nix-shell -p nixUnstable --command \"nix --experimental-features 'nix-command flakes' ${cmd}\"";
  join = builtins.concatStringsSep " && ";
in
{
  programs.zsh = {
    autocd = true;
    dotDir = ".config/zsh";
    enable = true;
    history = {
      path = "$ZDOTDIR/.zsh_history";
    };
    shellAliases = rec {
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      _ = "cd ~/_ && vim .";

      dstroy = "fd -H .DS_Store | xargs sudo rm";

      g = "git";
      ga = "git add";
      gap = "${ga} --patch";
      gb = "git branch";
      gbc = "${gb} --show-current";
      gc = "git commit";
      gca = "${gc} --amend";
      gcam = "${gc} -am";
      gcane = "${gc} --amend --no-edit";
      gcm = "${gc} -m";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gcpa = "${gcp} --abort";
      gd = "git diff";
      gd- = "git diff HEAD~";
      gdm = "${gd} main || ${gd} master";
      ghist = "git hist";
      gl = "git pull";
      glo = "git lo";
      glog = "git log";
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
      grbm = "${grb} main || ${grb} master";
      grev = "git rev-parse HEAD";
      grh = "${gr} --hard";
      groot = "cd \$(git rev-parse --show-toplevel)";
      grpo = "git remote prune origin";
      grs = "git restore";
      gs = "${gss} --short";
      gss = "git status";
      gst = "git stash";
      gstp = "${gst} pop";
      gsw = "git switch";
      gswm = "${gsw} main || ${gsw} master";

      ghb = "gh browse";
      ghc = "gh pr checkout";
      ghi = "gh issue list";
      ghiv = "gh issue view";
      ghp = "gh pr list";
      ghpv = "gh pr view";
      ghv = "gh pr view --web";

      r = "bin/rails";
      rdbm = "${r} db:migrate";
      rdbr = "${r} db:rollback";
      rdbs = "${r} db:seed";

      b = "bundle";
      be = "${b} exec";
      bi = "${b} install";
      bu = "${b} update";

      nupf = join [
        "cd $HOME/_"
        "rm flake.lock"
        hms
        "${gcam} 'update flakes'"
        gp
        "cd -"
      ];

      # home-manager switch
      hms = join [
        "cd $HOME/_"
        "rm -rf ${config.xdg.configHome}/nvim/lua"
        "${flake "flake lock --update-input fnl"}"
        "${flake "build --out-link ${config.xdg.configHome}/nixpkgs/result --impure '$HOME/_#home'"}"
        "${config.xdg.configHome}/nixpkgs/result/activate"
        sz
        "cd -"
      ];
      hsm = hms;

      c = "clear";

      ls = "exa";
      lsa = "exa -Fla";

      md = "mkdir";

      sz = "source ${config.xdg.configHome}/zsh/.zshrc";

      spd = "spotifyd --no-daemon >/dev/null &";
      spnd = "spotifyd --no-daemon";

      ncg = "nix-collect-garbage";
      ns = " open https://search.nixos.org/packages\\?channel=unstable";

      sc = "systemctl";
      jc = "journalctl";

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
      wiki = "cd ~/wiki && vim ~/wiki/index.norg && cd -";
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
    '';
    sessionVariables =
      let
        pathJoin = builtins.concatStringsSep ":";
      in
      rec {
        BROWSER = "open";
        CARGO_BIN = "${config.xdg.configHome}/.cargo/bin";
        CLICOLOR = 1;
        COLORTERM = "truecolor";
        EDITOR = "nvim";
        GNUPGHOME = "${config.xdg.dataHome}/gnupg";
        GOBIN = "${GOPATH}/bin";
        GOPATH = "${config.xdg.configHome}/go";
        KEYTIMEOUT = 1;
        KUBECONFIG = pathJoin [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
        NIX_BIN = "$HOME/.nix-profile/bin";
        NIX_PATH = pathJoin [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
        BREW_SBIN = "/usr/local/sbin";
        PATH = pathJoin [ CARGO_BIN GOBIN NIX_BIN BREW_SBIN "$PATH" ];
        PROMPT = "${cyan "\\$USER"}${blue "@\\$HOST"} ${blue "%3~"} ${magenta "\\$GIT_BRANCH"} ${red "\\$GIT_STATUS"} \n%(?.${green "❯"}.${red "❯"}) ";
        SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph";
        VIM_SESSION_PATH = "/tmp/session.vim";
        _ZL_DATA = "${config.xdg.dataHome}/z/zlua";
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
