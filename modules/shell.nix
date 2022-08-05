{ config, pkgs, lib, ... }:
let
  color = color: text: "%F{${color}}${text}%f";
  cyan = color "cyan";
  blue = color "blue";
  magenta = color "magenta";
  red = color "red";
  green = color "green";

  join = builtins.concatStringsSep " && ";
  cmdJoin = builtins.concatStringsSep "; ";
  spaceJoin = builtins.concatStringsSep " ";
  commaJoin = builtins.concatStringsSep ",";
  value = k: v: "\"${k}\":\"${v}\"";
in
{
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

      _ = cmdJoin [
        "tmux new-session -ds dotfiles -c $HOME/_ 2>/dev/null"
        "tmux switch-client -t dotfiles 2>/dev/null || tmux attach-session -t dotfiles"
      ];

      src = "cd $HOME/src";

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
      gclean = "${gb} | cut -c 3- | gum choose --no-limit | xargs ${gb} -D";
      gcm = ''${gc} -m "$(gum input)" -m "$(gum write)"'';
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
      gsw = "git switch";
      gswm = "${gsw} main || ${gsw} master";
      gundo = "git reset HEAD~1 --mixed";

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

      nupf = join [ "cd $HOME/_" "rm flake.lock" hms "${gcam} 'bump flakes'" gp "cd -" ];

      # home-manager switch
      hms = join [
        "cd $HOME/_"
        "rm -rf ${config.xdg.configHome}/nvim/lua"
        "nix flake lock --update-input fnl --update-input saturn"
        "nix build --out-link ${config.xdg.configHome}/nixpkgs/result --impure .#home"
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

      scim = "sc-im";

      ta = "tmux attach";
      tat = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tls = "tmux list-sessions";
      tn = cmdJoin [
        "SESSION=`ls $HOME/src | gum filter`"
        "tmux new-session -ds $SESSION -c $HOME/src/$SESSION 2>/dev/null"
        "tmux switch-client -t $SESSION 2>/dev/null || tmux attach -t $SESSION"
      ];

      dwlos = "printf 热爱开源 | pbcopy";
      dwnh = "printf 你好 | pbcopy";

      vi = "nvim";
      v = "${vi} .";
      vim = "${vi}";

      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; vim $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      wiki = "cd $HOME/wiki && vim index.norg && cd -";

      x = "exit";
      demo =
        (spaceJoin
          [
            "ttyd"
            "-B"
            "-t fontFamily=\"SF Mono\""
            "-t fontSize=22"
            "-t lineHeight=1.2"
            "-t customGlyphs=true"
            ("-t 'theme={" + commaJoin
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
              ] + "}' zsh")
          ]);

      prompt = "PROMPT='${color "#5a56e0" ">"} ' && clear";
    };
    defaultKeymap = "viins";
    initExtraBeforeCompInit = ''
      fpath+="$HOME/.nix-profile/share/zsh/site-functions"
      fpath+="$HOME/.nix-profile/share/zsh/5.8/functions"

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      function historysearch() {
        BUFFER="$(gum filter < $HISTFILE)"
        zle -w end-of-line
      }
      zle -N historysearch
      bindkey "^r" historysearch

      function tmuxsessions() { tn }
      zle -N tmuxsessions
      bindkey "^t" tmuxsessions
    '';
    initExtra = ''
      setopt prompt_subst

      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete

      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
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

        export PROMPT="%F{cyan}\$USER%f%F{blue}@\$HOST%f %F{blue}%3~%f %F{magenta}\$GIT_BRANCH%f %F{red}\$GIT_STATUS%f
      %(?.%F{green}❯%f.%F{red}❯%f) "
    '';
    sessionVariables =
      let
        pathJoin = builtins.concatStringsSep
          ":";
      in
      rec {
        BREW_SBIN = "/usr/local/sbin";
        BROWSER = "open";
        CARGO_BIN = "${config.xdg.configHome}/.cargo/bin";
        CLICOLOR = 1;
        COLORTERM = "truecolor";
        EDITOR = "nvim";
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
        KUBECONFIG = pathJoin [ "$HOME/.kube/config" "$HOME/.kube/config.shopify.cloudplatform" ];
        NIXPKGS_ALLOW_BROKEN = 1;
        NIX_BIN = "$HOME/.nix-profile/bin";
        NIX_PATH = pathJoin [ "$NIX_PATH" "$HOME/.nix-defexpr/channels" ];
        SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph";
        VIM_SESSION_PATH = "/tmp/session.vim";
        _ZL_DATA = "${config.xdg.dataHome}/z/zlua";
        PATH = pathJoin [
          CARGO_BIN
          NIX_BIN
          BREW_SBIN
          GOBIN
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
