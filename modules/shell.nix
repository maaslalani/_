{
  config,
  pkgs,
  lib,
  ...
}: let
  color = color: text: "%F{${color}}${text}%f";
  cyan = color "cyan";
  blue = color "blue";
  magenta = color "magenta";
  red = color "red";
  green = color "green";

  join = builtins.concatStringsSep " && ";
  spaceJoin = builtins.concatStringsSep " ";
  commaJoin = builtins.concatStringsSep ",";
  value = k: v: "\"${k}\":\"${v}\"";
in {
  programs.zsh = {
    autocd = true;
    dotDir = ".config/zsh";
    enable = true;
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      path = "$ZDOTDIR/.history";
      share = true;
    };
    shellAliases = rec {
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      ts = "tmux switch -t";
      ta = "tmux attach -t";
      tn = "tmux new";

      t = "SESSION=`ls $SRC | gum filter --height 10` && ${tn} -ds $SESSION -c $SRC/$SESSION; ${ts} $SESSION";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tls = "tmux list-sessions";

      _ = "${tn} -ds dotfiles -c ~/_; ${ts} dotfiles";
      src = "cd $HOME/src";

      dstroy = "fd -IH .DS_Store | xargs sudo rm";

      spoon = "open -a ${pkgs.hammerspoon}/Applications/Hammerspoon.app";

      g = "git";
      ga = "git add";
      gap = "${ga} --patch";
      gb = "git branch";
      gbc = "${gb} --show-current";
      gc = "git commit";
      gca = "${gc} --amend";
      gcm = "${gc} -m";
      gcam = "${gc} -am";
      gcane = "${gc} --amend --no-edit";
      gclean = "${gb} | cut -c 3- | gum choose --no-limit | xargs ${gb} -D";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gcpa = "${gcp} --abort";
      gd = "git diff";
      gd- = "git diff HEAD~";
      gdh = "git diff HEAD";
      gdm = "${gd} main || ${gd} master";
      ghist = "git log --pretty=format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\" --date=short";
      gl = "git pull";
      glo = "git log --oneline -n 20";
      glog = "git log";
      gm = "git merge";
      gma = "${gm} --abort";
      gopen = "git config --get remote.origin.url | xargs open";
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
      gundo = "git reset HEAD~1 --mixed";
      gsw = "git switch";
      gswc = "git switch --create";
      gswm = "${gsw} main || ${gsw} master";
      gw = "git worktree";
      gwa = "${gw} add";
      gwl = "${gw} list";
      gwp = "${gw} prune";
      gwd = "${gw} remove";
      ghb = "gh browse";
      ghco = "gh pr list | cut -f1,2 | gum choose | cut -f1 | xargs gh pr checkout";
      ghi = "gh issue list";
      ghiv = "gh issue view";
      ghp = "gh pr list";
      ghpv = "gh pr view";
      ghv = "gh pr view --web";

      goi = "go install";
      grg = "go run ./...";
      gtg = "go test ./...";
      gmt = "go mod tidy";
      gme = "go mod edit -replace $(go list -m -f '{{if not .Indirect}}{{.Path}}{{end}}' all | gum filter --height 10)=../$(ls ../ | gum choose)";

      r = "bin/rails";
      rdbm = "${r} db:migrate";
      rdbr = "${r} db:rollback";
      rdbs = "${r} db:seed";

      b = "bundle";
      be = "${b} exec";
      bi = "${b} install";
      bu = "${b} update";

      nupf = join ["cd $HOME/_" "rm flake.lock" hms "${gcam} 'bump flakes'" gp "cd -"];

      # home-manager switch
      hms = join [
        "cd $HOME/_"
        "nix flake lock --update-input fnl"
        "nix build --out-link ${config.xdg.configHome}/nixpkgs/result --impure .#home"
        "${config.xdg.configHome}/nixpkgs/result/activate"
        sz
        "cd -"
      ];
      hsm = hms;

      c = "clear";

      ls = "exa";
      lsa = "exa -Fla";
      sl = "${ls}";
      tree = "${ls} -T";

      md = "mkdir";

      sz = "source ${config.xdg.configHome}/zsh/.zshrc";

      spd = "spotifyd --no-daemon >/dev/null &";
      spnd = "spotifyd --no-daemon";

      ncg = "nix-collect-garbage";
      ns = " open https://search.nixos.org/packages\\?channel=unstable";

      sc = "systemctl";
      jc = "journalctl";

      scim = "sc-im";

      dwlos = "printf 热爱开源 | pbcopy";
      dwnh = "printf 你好 | pbcopy";

      hx = "hx";
      v = "hx .";
      vi = "hx";
      vim = "hx";

      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; hx $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      wiki = "cd $HOME/wiki && hx index.md && cd -";

      sk8 = "ssh skate.ssh.toys";

      x = "exit";
      demo =
        spaceJoin
        [
          "ttyd"
          "-B"
          "-t fontFamily=\"SF Mono\""
          "-t fontSize=22"
          "-t lineHeight=1.2"
          "-t customGlyphs=true"
          ("-t 'theme={"
            + commaJoin
            [
              (value "background" "#171717")
              (value "foreground" "#dddddd")
              (value "black" "#000000")
              (value "brightBlack" "#4d4d4d")
              (value "red" "#c73b1d")
              (value "brightRed" "#e82100")
              (value "green" "#00a800")
              (value "brightGreen" "#00db00")
              (value "yellow" "#acaf15")
              (value "brightYellow" "#e5e900")
              (value "blue" "#3854FC")
              (value "brightBlue" "#566BF9")
              (value "magenta" "#d533ce")
              (value "brightMagenta" "#e83ae9")
              (value "cyan" "#2cbac9")
              (value "brightCyan" "#00e6e7")
              (value "white" "#bfbfbf")
              (value "brightWhite" "#e6e6e6")
            ]
            + "}' zsh")
        ];
    };
    defaultKeymap = "viins";
    initExtraBeforeCompInit = ''
      fpath+="$HOME/.nix-profile/share/zsh/site-functions"
      fpath+="$HOME/.nix-profile/share/zsh/5.8/functions"

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      function hs() {
        BUFFER="$(fc -ln 0 | gum filter --value "$BUFFER")"
        zle -w end-of-line
      }
      zle -N hs
      bindkey "^r" hs

      function fs() {
        BUFFER+="$(gum filter)"
        zle -w end-of-line
      }
      zle -N fs
      bindkey "^t" fs
    '';
    initExtra = ''
      setopt prompt_subst
      setopt histignorealldups

      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete

      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      precmd() {
        if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
          GIT_BRANCH="($(git branch --show-current))"
          GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
        else
          unset GIT_BRANCH
          unset GIT_STATUS
        fi
      }

      export GPG_TTY=$(tty)

        export PROMPT="%F{blue}%3~%f %F{magenta}\$GIT_BRANCH%f %F{red}\$GIT_STATUS%f
      %(?.%F{green}>%f.%F{red}>%f) "
    '';
    sessionVariables = let
      pathJoin =
        builtins.concatStringsSep
        ":";
    in rec {
      XDG_DATA_HOME = config.xdg.dataHome;
      XDG_CONFIG_HOME = config.xdg.configHome;
      XDG_CACHE_HOME = config.xdg.cacheHome;
      AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
      AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
      BREW_SBIN = "/usr/local/sbin";
      BROWSER = "open";
      CARGO_BIN = "${config.xdg.configHome}/.cargo/bin";
      CLICOLOR = 1;
      COLORTERM = "truecolor";
      EDITOR = "hx";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GOBIN = "${GOPATH}/bin";
      GOPATH = "${config.xdg.configHome}/go";
      HOMEBREW_BIN = "/opt/homebrew/bin";
      HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
      HOMEBREW_PREFIX = "/opt/homebrew";
      HOMEBREW_REPOSITORY = "/opt/homebrew";
      HOMEBREW_SBIN = "/opt/homebrew/sbin";
      JAVA_HOME = "/Applications/Android Studio.app/Contents/jre/Contents/Home/";
      KEYTIMEOUT = 1;
      KUBECONFIG = pathJoin ["$HOME/.kube/config"];
      NIXPKGS_ALLOW_BROKEN = 1;
      NIX_BIN = "$HOME/.nix-profile/bin";
      BASH_SILENCE_DEPRECATION_WARNING = 1;
      NIX_PATH = pathJoin ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
      SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph";
      SRC = "$HOME/src";
      _ZL_DATA = "${config.xdg.dataHome}/z/zlua";
      PATH = pathJoin [
        CARGO_BIN
        GOBIN
        NIX_BIN
        BREW_SBIN
        HOMEBREW_BIN
        HOMEBREW_SBIN
        "$PATH"
      ];
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
