{
  config,
  pkgs,
  ...
}: let
  join = builtins.concatStringsSep " && ";
  pathJoin = builtins.concatStringsSep ":";

  environment = rec {
    # BROWSER = "open";
    LOCAL_BIN = "$HOME/.local/bin";
    COLORTERM = "truecolor";
    EDITOR = "hx";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    GOBIN = "${GOPATH}/bin";
    GOPATH = "${config.xdg.configHome}/go";
    CARGO_BIN = "$HOME/.cargo/bin";
    KEYTIMEOUT = "1";
    NIX_BIN = "$HOME/.nix-profile/bin";
    NIX_PATH = pathJoin ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
    OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
    TYPST_FONT_PATHS = "$HOME/.nix-profile/share/fonts";
    SHELL = "zsh";
    SHELL_SESSIONS_DISABLE = "1";
    SRC = "$HOME/src";
    XDG_CACHE_HOME = config.xdg.cacheHome;
    XDG_CONFIG_HOME = config.xdg.configHome;
    NODE_NO_WARNINGS = "1";
    XDG_DATA_HOME = config.xdg.dataHome;

    PATH = pathJoin [
      GOBIN
      NIX_BIN
      LOCAL_BIN
      CARGO_BIN
      "$PATH"
    ];
  };

  sz = join [
    "unset __HM_ZSH_SESS_VARS_SOURCED"
    "unset __HM_SESS_VARS_SOURCED"
    "source ${config.xdg.configHome}/zsh/.zshrc"
  ];

  aliases = let
    navigation = {
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      src = "cd $HOME/src";
      groot = "cd \$(git rev-parse --show-toplevel)";
      recipes = "cd $HOME/Library/Mobile\\ Documents/iCloud~org~cooklang~cooklangapp/Documents";
    };

    editor = {
      v = "$EDITOR";
      vi = "$EDITOR";
      vim = "$EDITOR";
    };

    git = rec {
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
      gcm = "${gc} -m";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gcpa = "${gcp} --abort";
      gd = "git diff";
      gd- = "git diff HEAD~";
      gdh = "git diff HEAD";
      gdm = "${gd} main || ${gd} master";
      ghb = "gh browse";
      ghco = " ${ghpl} | cut -f1,2 | gum filter --header 'Checkout PR' | cut -f1 | xargs gh pr checkout";
      ghil = "gh issue list";
      ghist = "git log --pretty=format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\" --date=short";
      ghiv = "gh issue view";
      ghpl = "gh pr list";
      ghpv = "gh pr view";
      ghprv = "${ghpv} --web";
      ghpvw = "${ghpv} --web";
      pr = "${ghpv} --web";
      gl = "git pull";
      glm = "git -C $HOME/Developer/copilot pull";
      glr = "${gl} --rebase";
      glo = "git log --oneline -n 20";
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
      grpo = "git remote prune origin";
      grs = "git restore";
      gs = "${gss} --short";
      gss = "git status";
      gst = "git stash";
      gstp = "${gst} pop";
      gsw = "git switch";
      gswc = "git switch --create";
      gswm = "${gsw} main || ${gsw} master";
      gundo = "git reset HEAD~1 --mixed";
      gw = "git worktree";
      gwa = "${gw} add";
      gwd = "${gw} remove";
      gwl = "${gw} list";
      gwp = "${gw} prune";
    };

    files = rec {
      ls = "eza";
      lsa = "eza -laF";
      sl = ls;
      tree = "${ls} -T";
      md = "mkdir";
      dstroy = "fd -IH .DS_Store | xargs sudo rm";
    };

    go = {
      grg = "go run ./...";
      goi = "go install";
    };

    nix = {
      hms = "nix build $HOME/_#home -o $HOME/_/result && $HOME/_/result/activate && ${sz} && (tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null || true)";
      inherit sz;
      ncg = "nix-collect-garbage";
      nixd = "sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist && sudo launchctl kickstart -k system/org.nixos.nix-daemon";
      ns = "open https://search.nixos.org/packages\\?channel=unstable";
    };

    misc = {
      _ = "tmux switch -t Dotfiles";
      branch = "__branch";
      minecraft = join [
        "cd $HOME/.local/share/minecraft"
        "grep -qx 'eula=true' eula.txt || { echo 'Set eula=true in eula.txt before starting the server.'; false; }"
        "java -Xmx1024M -Xms1024M -jar ~/.local/share/minecraft/server.jar nogui"
      ];
      notes = "cd $NOTES";
      todo = "$EDITOR $NOTES/todo.md";

      cop = "copilot --yolo";
      _cop = "(test -f ./dist-cli/index.js || npm run build) && ./dist-cli/index.js --yolo";

      nrbw = "npm run build:watch";

      color = "pastel pick";
      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; $EDITOR $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      x = "exit";
      q = "exit";
      ":q" = "exit";
    };
  in
    navigation // editor // git // files // nix // go // misc;
in {
  programs.zsh = {
    autocd = true;
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    shellAliases = aliases;
    defaultKeymap = "viins";
    initContent = ''
      if [ -d "$HOME/icloud" ]; then
        export NOTES="$HOME/icloud/Documents/notes"
      else
        export NOTES="$HOME/Documents/notes"
      fi

      if [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1 && [ -d "$HOME/Developer/copilot" ]; then
        tmux has-session -t=copilot 2>/dev/null || tmux new-session -ds copilot -c "$HOME/Developer/copilot"
      fi

      fpath+="$HOME/.nix-profile/share/zsh/site-functions"
      fpath+="$HOME/.nix-profile/share/zsh/5.8/functions"

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      setopt prompt_subst
      setopt histignorealldups

      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete

      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      __branch_remote_exists() {
        local REPO="$1"
        local BRANCH="$2"

        git -C "$REPO" ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1
      }

      __branch_local_exists() {
        local REPO="$1"
        local BRANCH="$2"

        git -C "$REPO" show-ref --verify --quiet "refs/heads/$BRANCH" 2>/dev/null
      }

      __branch_origin_exists() {
        local REPO="$1"
        local BRANCH="$2"

        git -C "$REPO" show-ref --verify --quiet "refs/remotes/origin/$BRANCH" 2>/dev/null || \
          __branch_remote_exists "$REPO" "$BRANCH"
      }

      __branch_resolve_name() {
        local REPO="$1"
        local NAME="$2"
        local SHORT_NAME="''${NAME#maaslalani/}"
        local BRANCH="maaslalani/$SHORT_NAME"

        if __branch_remote_exists "$REPO" "$NAME"; then
          BRANCH="$NAME"
        fi

        echo "$BRANCH"
      }

      __branch_safe_name() {
        local BRANCH="$1"
        local SHORT_NAME="''${BRANCH#maaslalani/}"

        echo "''${SHORT_NAME//\//.}"
      }

      __branch_add_worktree() {
        local REPO="$1"
        local WORKTREE="$2"
        local BRANCH="$3"

        if __branch_local_exists "$REPO" "$BRANCH"; then
          git -C "$REPO" worktree add "$WORKTREE" "$BRANCH"
        elif __branch_origin_exists "$REPO" "$BRANCH"; then
          git -C "$REPO" fetch origin "refs/heads/$BRANCH:refs/remotes/origin/$BRANCH"
          git -C "$REPO" worktree add --track -b "$BRANCH" "$WORKTREE" "origin/$BRANCH"
        else
          git -C "$REPO" worktree add -b "$BRANCH" "$WORKTREE" main
        fi
      }

      __branch_start_session() {
        local SESSION="$1"
        local WORKTREE="$2"

        tmux new-session -ds "$SESSION" -c "$WORKTREE" -n "" "$SHELL"
        tmux new-window -t "$SESSION" -c "$WORKTREE" -n "build" "npm install && npm run build:watch"
        tmux select-window -t "$SESSION:1"
        tmux switch-client -t "$SESSION"
      }

      __branch() {
        local NAME="''${1:?Usage: branch <name>}"
        local REPO="$HOME/Developer/copilot"
        local BRANCH="$(__branch_resolve_name "$REPO" "$NAME")"
        local SAFE_NAME="$(__branch_safe_name "$BRANCH")"
        local SESSION="copilot_$SAFE_NAME"
        local WORKTREE="$HOME/Developer/copilot.$SAFE_NAME"

        if tmux has-session -t "$SESSION" 2>/dev/null; then
          tmux switch-client -t "$SESSION"
          return
        fi

        if [ ! -d "$WORKTREE" ]; then
          __branch_add_worktree "$REPO" "$WORKTREE" "$BRANCH"
        fi

        __branch_start_session "$SESSION" "$WORKTREE"
      }

      precmd() {
        if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
          GIT_BRANCH="%F{magenta}(%B$(git branch --show-current)%b)%f"
          GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
        else
          unset GIT_BRANCH
          unset GIT_STATUS
        fi
      }

      export GPG_TTY=$(tty)

      if [ "$DEMO" = "true" ]; then
        export PROMPT="%F{#5a56e0}>%f "
      else
        export PROMPT="%F{blue}%3~%f \$GIT_BRANCH %F{red}\$GIT_STATUS%f
      %(?.%F{green}>%f.%F{red}>%f) "
      fi
    '';
    sessionVariables = environment;
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
