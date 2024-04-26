{
  config,
  pkgs,
  ...
}: let
  join = builtins.concatStringsSep " && ";
  pathJoin = builtins.concatStringsSep ":";

  environment = rec {
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    BASH_SILENCE_DEPRECATION_WARNING = 1;
    BREW_SBIN = "/usr/local/sbin";
    BROWSER = "open";
    CARGO_BIN = "${CARGO_HOME}/bin";
    CARGO_HOME = "${config.xdg.configHome}/.cargo";
    CLICOLOR = 1;
    COLORTERM = "truecolor";
    DENO_BIN = "$HOME/.deno/bin";
    EDITOR = "hx";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    GOBIN = "${GOPATH}/bin";
    GOPATH = "${config.xdg.configHome}/go";
    HANDLER = "copilot";
    HOMEBREW_BIN = "${HOMEBREW_PREFIX}/bin";
    HOMEBREW_CELLAR = "${HOMEBREW_PREFIX}/Cellar";
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_REPOSITORY = HOMEBREW_PREFIX;
    HOMEBREW_SBIN = "${HOMEBREW_PREFIX}/sbin";
    JAVA_HOME = "/Applications/Android Studio.app/Contents/jre/Contents/Home/";
    KEYTIMEOUT = 1;
    KUBECONFIG = pathJoin ["$HOME/.kube/config"];
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_BROKEN = 1;
    NIXPKGS_ALLOW_UNFREE = 1;
    NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = 1;
    NIX_BIN = "$HOME/.nix-profile/bin";
    NIX_PATH = pathJoin ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
    RUSTUP_HOME = "${config.xdg.configHome}/.rustup";
    SHELL = "zsh";
    SOLARGRAPH_CACHE = "${config.xdg.cacheHome}/solargraph";
    SRC = "$HOME/src";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CACHE_HOME = config.xdg.cacheHome;
    XDG_CONFIG_HOME = config.xdg.configHome;
    XDG_DATA_HOME = config.xdg.dataHome;
    _ZL_DATA = "${config.xdg.dataHome}/z/zlua";

    PATH = pathJoin [
      CARGO_BIN
      GOBIN
      NIX_BIN
      BREW_SBIN
      HOMEBREW_BIN
      HOMEBREW_SBIN
      DENO_BIN
      "$PATH"
    ];
  };

  aliases = rec {
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";

    v = "$EDITOR";
    vi = "$EDITOR";
    vim = "$EDITOR";
    nvim = "$EDITOR";

    ts = "tmux switch -t";
    ta = "tmux attach -t";
    tn = "tmux new";

    tkss = "tmux kill-session -t";
    tksv = "tmux kill-server";
    tls = "tmux list-sessions";

    _ = "${tn} -ds dotfiles -c ~/_ $SHELL; ${ts} dotfiles || ${ta} dotfiles";
    src = "cd $HOME/src";

    dstroy = "fd -IH .DS_Store | xargs sudo rm";

    g = "git";
    ga = "git add";
    gap = "${ga} --patch";
    gb = "git branch";
    gbc = "${gb} --show-current";
    gc = "git commit";
    gca = "${gc} --amend";
    gcai = ''MESSAGE=$(${gd} | mods "write a commit message for this diff") && gum write --value="$MESSAGE" && ${gcam} "$MESSAGE"'';
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
    ghco = "gh pr list | cut -f1,2 | gum choose | cut -f1 | xargs gh pr checkout";
    ghi = "gh issue list";
    ghist = "git log --pretty=format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\" --date=short";
    ghiv = "gh issue view";
    ghp = "gh pr list";
    ghpv = "gh pr view";
    ghv = "gh pr view --web";
    gl = "git pull";
    glo = "git log --oneline -n 20";
    glog = "git log";
    glrb = "${gl} --rebase";
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
    gswc = "git switch --create";
    gswm = "${gsw} main || ${gsw} master";
    gundo = "git reset HEAD~1 --mixed";
    gw = "git worktree";
    gwa = "${gw} add";
    gwd = "${gw} remove";
    gwl = "${gw} list";
    gwp = "${gw} prune";

    goi = "go install";
    grg = "go run ./...";
    gtg = "go test ./...";
    gmt = "go mod tidy";
    gmu = "go get -u $(go list -m -f '{{if not .Indirect}}{{.Path}}{{end}}' all | gum filter --height 10)";
    gme = "go mod edit -replace $(go list -m -f '{{if not .Indirect}}{{.Path}}{{end}}' all | gum filter --height 10)=$(realpath --relative-to=\"$\{PWD\}\" \"$(gum file --directory ..)\")";

    r = "bin/rails";
    rdbm = "${r} db:migrate";
    rdbr = "${r} db:rollback";
    rdbs = "${r} db:seed";

    b = "bundle";
    be = "${b} exec";
    bi = "${b} install";
    bu = "${b} update";

    nupf = join ["cd $HOME/_" "rm flake.lock" hms "${gcam} 'bump flakes'" gp "cd -"];

    nrs = "sudo nixos-rebuild switch";

    # home-manager switch
    hms = join [
      "cd $HOME/_"
      "nix flake lock --update-input fnl"
      "nix build --out-link ${config.xdg.configHome}/nixpkgs/result --impure .#${
        if pkgs.stdenv.isDarwin
        then "home"
        else "linux"
      }"
      "${config.xdg.configHome}/nixpkgs/result/activate"
      sz
      "skhd --reload"
      "cd -"
    ];
    hsm = hms;

    c = "clear";

    ls = "eza";
    lsa = "eza -laF";
    sl = "${ls}";
    tree = "${ls} -T";

    md = "mkdir";

    sz = join [
      "unset __HM_ZSH_SESS_VARS_SOURCED"
      "unset __HM_SESS_VARS_SOURCED"
      "source ${config.xdg.configHome}/zsh/.zshrc"
      "source ${config.xdg.configHome}/zsh/.zshenv"
    ];

    spd = "spotifyd --no-daemon >/dev/null &";
    spnd = "spotifyd --no-daemon";

    ncg = "nix-collect-garbage";
    ns = "open https://search.nixos.org/packages\\?channel=unstable";

    sc = "systemctl";
    jc = "journalctl";

    scim = "sc-im";

    dw = ''gum choose "热爱开源" "你好" | pbcopy'';

    scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; $EDITOR $FILE +startinsert && pbcopy < $FILE; rm $FILE";
    weather = "curl http://v2.wttr.in";
    wiki = "cd $HOME/wiki && $EDITOR . && cd -";

    sk8 = "ssh skate.ssh.toys";

    x = "exit";

    o = "ollama";
    orl = "ollama run llama3";
  };
in {
  programs.bash = {
    enable = true;
    historySize = 1000;
    bashrcExtra = ''
      export PS1="\[\e[38;2;90;86;224m\]> \[\e[0m\]";
      export PROMPT="\[\e[38;2;90;86;224m\]> \[\e[0m\]";
    '';
    shellAliases = aliases;
    shellOptions = [];
    enableCompletion = false;
    sessionVariables = environment;
  };

  programs.fish = {
    enable = true;
    shellAliases = aliases;
  };

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
    shellAliases = aliases;
    defaultKeymap = "viins";
    initExtraBeforeCompInit = ''
      fpath+="$HOME/.nix-profile/share/zsh/site-functions"
      fpath+="$HOME/.nix-profile/share/zsh/5.8/functions"

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      function rm () {
        mv "$@" /tmp
      }

      function tss() {
        (
          exec </dev/tty
          exec <&1
          SESSION=`ls $SRC | gum filter --no-strict`
          DIRECTORY="$SRC/$SESSION"
          if [[ -z "$SESSION" ]]
          then
            SESSION="dotfiles"
            DIRECTORY="$HOME/_"
          fi
          tmux new -ds "$SESSION" -c "$DIRECTORY" "$SHELL" 2> /dev/null
          if [[ -n "$TMUX" ]]
          then
            tmux switch -t "$SESSION" 2> /dev/null
          else
            tmux attach -t "$SESSION" 2> /dev/null
          fi
        )
        zle reset-prompt
      }
      zle -N tss
      bindkey "^a" tss

      function hs() {
        BUFFER="$(fc -ln 0 | gum filter --value "$BUFFER")"
        zle -w end-of-line
      }
      zle -N hs
      bindkey "^r" hs

      function fs() {
        BUFFER+="$(fd | gum filter)"
        zle -w end-of-line
      }
      zle -N fs
      bindkey "^f" fs
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

      if [ "$DEMO" = "true" ]; then
        export PROMPT="%F{#5a56e0}>%f "
      else
        export PROMPT="%F{blue}%3~%f %F{magenta}\$GIT_BRANCH%f %F{red}\$GIT_STATUS%f
      %(?.%F{green}>%f.%F{red}>%f) "
      fi

      # secrets
      [ -z "$COPILOT_API_KEY" ] && export COPILOT_API_KEY="$(pass COPILOT_API_KEY)"
      [ -z "$OPENAI_API_KEY" ] && export OPENAI_API_KEY="$(pass OPENAI_API_KEY)"
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
}
