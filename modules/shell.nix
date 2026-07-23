{
  colors,
  config,
  identity,
  pkgs,
  ...
}: let
  syntaxHighlighting = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "5eb494852ebb99cf5c2c2bffee6b74e6f1bf38d0";
    sha256 = "8gyZe6OPVLMdfruHJAHcyYeuiyvMTLvuX1UnUOv8eg8=";
  };
  purePrompt = pkgs.pure-prompt.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace pure.zsh \
          --replace-fail 'if [[ $1 == precmd ]]; then' \
          'if [[ $1 == precmd && -n $prompt_pure_last_prompt ]]; then'
      '';
  });
  integrations = ''
    function __init_completion() {
      autoload -Uz compinit
      local zcompdump=${config.xdg.cacheHome}/zsh/zcompdump
      [[ -d ${config.xdg.cacheHome}/zsh ]] || mkdir -p ${config.xdg.cacheHome}/zsh
      if [[ -f $zcompdump ]]; then
        compinit -C -d "$zcompdump"
      else
        compinit -d "$zcompdump"
      fi
      unfunction __init_completion
    }

    function __init_zoxide() {
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      unfunction __init_zoxide
    }

    function __init_fzf() {
      source <(${pkgs.fzf}/bin/fzf --zsh)
      unfunction __init_fzf
    }

    function __init_ghostty() {
      setopt local_options no_aliases
      if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
        source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
      fi
      unfunction __init_ghostty
    }

    function __init_syntax_highlighting() {
      source ${syntaxHighlighting}/zsh-syntax-highlighting.plugin.zsh
      unfunction __init_syntax_highlighting
    }

    zsh-defer -m -p -r __init_ghostty
    zsh-defer -m -p -r __init_completion
    zsh-defer -m -p -r __init_zoxide
    zsh-defer -m -p -r __init_fzf
    zsh-defer -m __init_syntax_highlighting
  '';
in {
  programs.zsh = {
    autocd = true;
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    envExtra = ''
      unsetopt GLOBAL_RCS
    '';
    history = {
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    defaultKeymap = "viins";
    sessionVariables = rec {
      CARGO_BIN = "$HOME/.cargo/bin";
      COLORTERM = "truecolor";
      EDITOR = "hx";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GOBIN = "${GOPATH}/bin";
      GOPATH = "${config.xdg.configHome}/go";
      GROK_HOME = "${config.xdg.dataHome}/grok";
      KEYTIMEOUT = "1";
      LOCAL_BIN = "$HOME/.local/bin";
      NIX_BIN = "$HOME/.nix-profile/bin";
      NIX_PATH = builtins.concatStringsSep ":" ["$NIX_PATH" "$HOME/.nix-defexpr/channels"];
      NODE_NO_WARNINGS = "1";
      NOTES = "$HOME/Documents/notes";
      OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
      PATH = builtins.concatStringsSep ":" [GOBIN NIX_BIN LOCAL_BIN CARGO_BIN "$PATH"];
      RUSTC_WRAPPER = "sccache";
      SHELL = "${config.programs.zsh.package}/bin/zsh";
      SHELL_SESSIONS_DISABLE = "1";
      TYPST_FONT_PATHS = "$HOME/.nix-profile/share/fonts";
      XDG_CACHE_HOME = config.xdg.cacheHome;
      XDG_CONFIG_HOME = config.xdg.configHome;
      XDG_DATA_HOME = config.xdg.dataHome;
    };
    completionInit = "";
    initContent = ''
      source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh

      fpath+=(
        "$HOME/.nix-profile/share/zsh/site-functions"
        "${purePrompt}/share/zsh/site-functions"
      )

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      setopt combining_chars prompt_subst
      disable log

      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^?' backward-delete-char
      bindkey '^[[Z' reverse-menu-complete
      bindkey "$terminfo[kdch1]" delete-char
      bindkey "$terminfo[khome]" beginning-of-line
      bindkey "$terminfo[kend]" end-of-line
      bindkey "$terminfo[kcuu1]" up-line-or-search
      bindkey "$terminfo[kcud1]" down-line-or-search

      if [[ -z $__ETC_PROFILE_NIX_SOURCED && -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      [[ -n $TTY ]] && export GPG_TTY=$TTY

      PURE_PROMPT_SYMBOL='>'
      PURE_PROMPT_VICMD_SYMBOL='<'
      PURE_GIT_UP_ARROW='↑'
      PURE_GIT_DOWN_ARROW='↓'
      zstyle ':prompt:pure:git:arrow' color yellow
      zstyle ':prompt:pure:git:branch' color magenta
      zstyle ':prompt:pure:git:branch:cached' color magenta
      zstyle ':prompt:pure:git:dirty' color red
      autoload -Uz promptinit
      promptinit
      prompt pure

      ${integrations}
    '';
    shellAliases = rec {
      # navigation
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      src = "cd $HOME/src";
      groot = "cd \$(git rev-parse --show-toplevel)";
      recipes = "cd $HOME/Library/Mobile\\ Documents/iCloud~org~cooklang~cooklangapp/Documents";

      # editor
      v = "$EDITOR";
      vi = "$EDITOR";
      vim = "$EDITOR";

      # git
      g = "git";
      clone = ''() { local REPO="$HOME/Developer/$(basename "$1" .git)" && gh clone "$1" "$REPO/.git" -- --bare && git -C "$REPO/.git" worktree add "../$(git -C "$REPO/.git" symbolic-ref --short HEAD)" }'';
      ga = "git add";
      gap = "${ga} --patch";
      gb = "git branch";
      gbc = "${gb} --show-current";
      gc = "git commit";
      gcm = "git commit -m";
      gca = "${gc} --amend";
      gcam = "${gc} -am";
      gcane = "${gc} --amend --no-edit";
      gclean = "${gb} | cut -c 3- | gum choose --no-limit | xargs ${gb} -D";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gcpa = "${gcp} --abort";
      gd = "git diff";
      gd- = "git diff HEAD~";
      gdh = "git diff HEAD";
      gdm = "${gd} main";
      ghb = "gh browse";
      ghco = " ${ghpl} | cut -f1,2 | gum filter --header 'Checkout PR' | cut -f1 | xargs gh pr checkout";
      ghil = "gh issue list";
      ghist = "git log --pretty=format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\" --date=short";
      ghiv = "gh issue view";
      ghpl = "gh pr list";
      ghpv = "gh pr view";
      pr = "${ghpv} --web";
      gl = "git pull";
      glm = "git -C $HOME/Developer/copilot pull";
      glr = "${gl} --rebase";
      glo = "git log -n 20";
      glog = "git log --oneline -n 20";
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
      grbm = "${grb} main";
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
      gswm = "${gsw} main";
      gundo = "git reset HEAD~1 --mixed";
      gw = "git worktree";
      gwa = ''() { git worktree add -b "${identity.githubUser}/$1" "$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")/$1" }'';
      gwd = "${gw} remove . && cd ..";
      gwl = "${gw} list";
      gwp = "${gw} prune";

      # files
      ls = "eza";
      lsa = "eza -laF";
      sl = ls;
      tree = "${ls} -T";
      md = "mkdir";
      dstroy = "fd -IH .DS_Store | xargs sudo rm";

      # go
      grg = "go run ./...";
      goi = "go install";

      # nix
      hms = builtins.concatStringsSep " && " [
        "nh home switch -c maas -o $HOME/_/result ."
        "rm -f ${config.xdg.cacheHome}/zsh/zcompdump"
        "(tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null || true)"
        sz
        "aerospace reload-config"
      ];
      hsm = hms;
      ncg = "nix-collect-garbage";
      nixd = "sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist && sudo launchctl kickstart -k system/org.nixos.nix-daemon";
      ns = "open https://search.nixos.org/packages\\?channel=unstable";

      # misc
      _ = "tmux switch -t Dotfiles";
      sz = builtins.concatStringsSep " && " [
        "unset __HM_ZSH_SESS_VARS_SOURCED"
        "unset __HM_SESS_VARS_SOURCED"
        "exec zsh"
      ];
      tn = "tmux-session-picker";
      notes = "tmux switch -t Notes";
      todo = "$EDITOR $NOTES/todo.md";
      insomniac = "sudo pmset -a disablesleep $((1 - $(pmset -g | awk '/SleepDisabled/ {print $2}'))) && pmset -g | grep SleepDisabled";

      dev = "devin --permission-mode bypass";

      cop = "copilot --yolo";
      _cop = "pnpm run cli";

      npm = "pnpm";

      color = "pastel pick";
      scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; $EDITOR $FILE +startinsert && pbcopy < $FILE; rm $FILE";
      weather = "curl http://v2.wttr.in";
      x = "exit";
      q = "exit";
      ":q" = "exit";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.nh = {
    enable = true;
  };

  programs.fzf = {
    colors = {
      bg = colors.primary.background;
      "bg+" = colors.primary.background;
      fg = colors.primary.foreground;
      "fg+" = colors.bright.white;
      hl = colors.normal.magenta;
      "hl+" = colors.bright.magenta;
      ghost = colors.bright.black;
      gutter = colors.primary.background;
      info = colors.bright.black;
      pointer = colors.bright.blue;
      prompt = colors.bright.blue;
      query = colors.primary.foreground;
      separator = colors.separator;
    };
    enable = true;
    enableZshIntegration = false;
  };
}
