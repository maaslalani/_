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
      ghpvw = "${ghpv} --web";
      gl = "git pull";
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
      ns = "open https://search.nixos.org/packages\\?channel=unstable";
    };

    misc = {
      _ = "cd $HOME/_";
      mc = join [
        "cd $HOME/_"
        "grep -qx 'eula=true' eula.txt || { echo 'Set eula=true in eula.txt before starting the server.'; false; }"
        "(tmux has-session -t minecraft 2>/dev/null || tmux new-session -d -s minecraft 'cd $HOME/_ && java -jar versions/26.1.2/server-26.1.2.jar nogui')"
        "ngrok tcp 25565"
      ];
      notes = "cd $NOTES";
      todo = "$EDITOR $NOTES/todo.typ";

      cop = "copilot";
      _cop = "npm run cli";
      color = "pastel pick";
      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; $EDITOR $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      x = "exit";
      q = "exit";
      ":q" = "exit";
    };
    jj = rec {
      j = "jj";
      js = "jj status";
      jl = "jj log";
      jd = "jj diff";
      jds = "jj diff --stat";
      jn = "jj new";
      jde = "jj describe";
      je = "jj edit";
      jci = "jj commit";
      jsq = "jj squash"; # git commit --amend
      jnm = "jj new main"; # git checkout -b main
      jp = "jj git push";
      jpb = "jj git push --bookmark";
      jf = "jj git fetch";
      jrb = "jj rebase -d main";
      ju = "jj undo";
      jop = "jj op log";
      jb = "jj bookmark list";
      jbc = "jj bookmark create";
      jbm = "jj bookmark move";
      jbd = "jj bookmark delete";
    };
  in
    navigation // editor // git // jj // files // nix // go // misc;
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

      branch() {
        local name=$(gh api user --jq '.login')/$1
        cd $HOME/Developer/copilot
        if git worktree list | grep -q "\[$name\]"; then
          wt switch $name
        elif git worktree list | grep -q "\[$1\]"; then
          wt switch $1
        elif git ls-remote --heads origin "$1" | grep -q .; then
          wt switch -c $1 --execute npm -- install --loglevel=error --no-audit --no-fund
        else
          wt switch -c $name --execute npm -- install --loglevel=error --no-audit --no-fund
        fi
      }

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

      precmd() {
        if jj root --ignore-working-copy &>/dev/null; then
          local change_prefix change_rest bookmark
          change_prefix=$(jj log --ignore-working-copy -r @ --no-graph -T 'change_id.shortest(8).prefix()' 2>/dev/null)
          change_rest=$(jj log --ignore-working-copy -r @ --no-graph -T 'change_id.shortest(8).rest()' 2>/dev/null)
          bookmark=$(jj log --ignore-working-copy -r @ --no-graph -T 'if(bookmarks, bookmarks, "")' 2>/dev/null)
          local change="%B%F{magenta}$change_prefix%f%b%F{240}$change_rest%f"
          if [ -n "$bookmark" ]; then
            GIT_BRANCH="%F{magenta}(%B$bookmark%b)%f $change"
          else
            GIT_BRANCH="$change"
          fi
          GIT_STATUS=$(jj status --ignore-working-copy 2>/dev/null | awk '/^Working copy changes:/{found=1; next} found && /^[A-Z] /{printf $1} found && !/^[A-Z] /{found=0}')
        elif [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
          GIT_BRANCH="%F{magenta}(%B$(git branch --show-current)%b)%f"
          GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
        else
          unset GIT_BRANCH
          unset GIT_STATUS
        fi
      }

      eval "$(wt config shell init zsh)"

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
