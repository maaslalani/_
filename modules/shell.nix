{
  colors,
  config,
  pkgs,
  ...
}: let
  purePrompt = pkgs.pure-prompt.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace pure.zsh \
          --replace-fail 'if [[ $1 == precmd ]]; then' \
          'if [[ $1 == precmd && -n $prompt_pure_last_prompt ]]; then'
      '';
  });
in {
  home.file.".hushlogin".text = "";
  home.packages = [pkgs.kache pkgs.terminal-notifier];
  home.sessionPath = ["${config.xdg.configHome}/go/bin" "$HOME/.local/bin" "$HOME/.cargo/bin"];

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
    sessionVariables = {
      COLORTERM = "truecolor";
      DO_NOT_TRACK = "1";
      EDITOR = "hx";
      GNUPGHOME = "${config.xdg.dataHome}/gnupg";
      GOBIN = "${config.xdg.configHome}/go/bin";
      GOPATH = "${config.xdg.configHome}/go";
      GROK_HOME = "${config.xdg.dataHome}/grok";
      KEYTIMEOUT = "1";
      NODE_NO_WARNINGS = "1";
      OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
      RUSTC_WRAPPER = "${pkgs.kache}/bin/kache";
      SHELL = "${config.programs.zsh.package}/bin/zsh";
      SHELL_SESSIONS_DISABLE = "1";
      TYPST_FONT_PATHS = "$HOME/.nix-profile/share/fonts";
    };
    syntaxHighlighting.enable = true;
    initContent = ''
      fpath+=("${purePrompt}/share/zsh/site-functions")

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
      gcm = "${gc} -m";
      gca = "${gc} --amend";
      gcam = "${gc} -am";
      gcane = "${gc} --amend --no-edit";
      gclean = "${gb} | cut -c 3- | gum choose --no-limit | xargs ${gb} -D";
      gcp = "git cherry-pick";
      gcpa = "${gcp} --abort";
      gd = "git diff";
      gd- = "${gd} HEAD~";
      gdh = "${gd} HEAD";
      hd = "hunk diff";
      gmb = "git merge-base origin/main HEAD";
      gds = "${gd} --stat $(${gmb})..HEAD";
      gdm = "${gd} $(${gmb})..HEAD";
      ghb = "gh browse";
      ghco = " ${ghpl} | cut -f1,2 | gum filter --header 'Checkout PR' | cut -f1 | xargs gh pr checkout";
      ghil = "gh issue list";
      ghist = "git log --pretty=format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\" --date=short";
      ghiv = "gh issue view";
      ghpl = "gh pr list --assignee @me";
      ghpv = "gh pr view";
      pr = "${ghpv} --web";
      gl = "git pull";
      glm = ''git -C "$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")/main" pull'';
      glr = "${gl} --rebase";
      glo = "git log -n 20";
      glob = "${gl} origin `${gbc}`";
      glog = "git log --oneline -n 20";
      gm = "git merge";
      gma = "${gm} --abort";
      gp = "git push";
      gpf = "${gp} --force-with-lease";
      gpos = "${gpf} origin HEAD:staging";
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
      rmu = "git clean -fd";
      gs = "${gss} --short";
      gss = "git status";
      gst = "git stash";
      gstp = "${gst} pop";
      gco = ''() { git fetch origin "$1":"$1" && git switch "$1" && cd apps/chisel && ./setup.sh }'';
      gsw = "git switch";
      gswc = "git switch --create";
      gswm = "${gsw} main";
      gundo = "git reset HEAD~1 --mixed";
      gw = "git worktree";
      gwd = "${gw} remove . && cd ..";
      gwl = "${gw} list";
      gwp = "${gw} prune";
      wt = ''
        () {
          setopt localoptions pipefail
          local ROOT="$HOME/Developer/devin-webapp" WT WIN LABEL BRANCH REF PR
          local NEW=false TRACK=true
          local -a CMD
          if [[ $# == 2 && "$1" == -b ]]; then
            NEW=true
            TRACK=false
            shift
          fi
          [[ $# == 1 && -n "$1" ]] || { printf 'Usage: wt <branch|pull-request-url> | wt -b <new-branch>\n' >&2; return 2 }
          BRANCH="$1"
          REF="refs/heads/$BRANCH"
          if [[ "$1" == *://* ]]; then
            [[ "$NEW" == false && "$1" =~ '^https://github[.]com/usacognition/devin-webapp/pull/[1-9][0-9]*([/#?].*)?$' ]] || {
              printf 'Expected a usacognition/devin-webapp pull request URL.\n' >&2; return 2
            }
            PR=$(gh pr view "$1" --json number,headRefName,isCrossRepository) || return
            BRANCH=$(jq -er 'if .isCrossRepository then "pr/\(.number)" else .headRefName end' <<< "$PR") || return
            REF=$(jq -er '"refs/pull/\(.number)/head"' <<< "$PR") || return
            TRACK=$(jq -er '.isCrossRepository | not | tostring' <<< "$PR") || return
          fi
          git check-ref-format --branch "$BRANCH" >/dev/null || return
          git -C "$ROOT" worktree prune || return
          WT=$(git -C "$ROOT" worktree list --porcelain | awk -v b="refs/heads/$BRANCH" '$1=="worktree"{w=substr($0,10)} $2==b{print w}') || return
          if [[ -n "$WT" ]]; then
            [[ "$NEW" == false ]] || { printf 'Branch already has a worktree: %s\n' "$BRANCH" >&2; return 2 }
            LABEL="''${WT#$ROOT/}"
            WIN=$(rex window ls --json | jq -r --arg l "$LABEL" 'first(.windows[] | select(.label==$l).window_id) // empty') || return
          else
            WT="$ROOT/$BRANCH"
            LABEL="$BRANCH"
            if [[ "$NEW" == false ]] && git -C "$ROOT" show-ref --verify --quiet "refs/heads/$BRANCH"; then
              git -C "$ROOT" worktree add "$WT" "$BRANCH" || return
            else
              [[ "$NEW" == false ]] || REF=refs/heads/main
              git -C "$ROOT" fetch origin "$REF" || return
              git -C "$ROOT" worktree add --no-track -b "$BRANCH" "$WT" FETCH_HEAD || return
              if [[ "$TRACK" == true ]]; then
                git -C "$ROOT" config "branch.$BRANCH.remote" origin && git -C "$ROOT" config "branch.$BRANCH.merge" "refs/heads/$BRANCH" || return
              fi
            fi
            CMD=(-- zsh -c './setup.sh && exec zsh')
          fi
          [[ -n "$WIN" ]] || WIN=$(rex window new "$LABEL" --cwd "$WT/apps/chisel" --json "''${CMD[@]}" | jq -er .window_id) || return
          rex window focus "$WIN" >/dev/null
        }'';

      # files
      cat = "bat";
      ls = "eza";
      lsa = "eza -laF";
      sl = ls;
      tree = "${ls} -T";
      md = "mkdir";
      dstroy = "fd --hidden --no-ignore --type f --glob .DS_Store --exec rm -- {}";

      # go
      grg = "go run ./...";
      goi = "go install";

      # rust
      cr = ''() { [[ "$PWD" == */apps/chisel ]] || cd apps/chisel || return; cargo run -- --permission-mode smart "$@" }'';
      cb = "cargo build";
      ct = "cargo test";
      cl = "cargo clippy";
      cf = "cargo fmt";
      ca = "cargo add";

      # zig
      zb = "zig build";
      zbr = "zig build run";
      zt = "zig build test";

      # nix
      hms = builtins.concatStringsSep " && " [
        ''nh home switch -c maas -o "$HOME/_/result" "$HOME/_"''
        "(herdr server reload-config 2>/dev/null || true)"
        "aerospace reload-config"
        sz
      ];
      hsm = hms;
      ncg = "nix-collect-garbage";
      nfu = "nix flake update";
      ndev = "nix develop";
      nixd = "sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist && sudo launchctl kickstart -k system/org.nixos.nix-daemon";
      ns = "open https://search.nixos.org/packages\\?channel=unstable";

      # misc
      _ = ''rex window focus Dotfiles >/dev/null 2>&1 || rex window new Dotfiles --cwd "$HOME/_" >/dev/null'';
      sz = builtins.concatStringsSep " && " [
        "unset __HM_ZSH_SESS_VARS_SOURCED"
        "unset __HM_SESS_VARS_SOURCED"
        "exec zsh"
      ];
      tn = "herdr-workspace-picker";
      notes = "herdr-workspace-picker Notes";
      todo = "$EDITOR $NOTES/todo.md";
      insomniac = "sudo pmset -a disablesleep $((1 - $(pmset -g | awk '/SleepDisabled/ {print $2}'))) && pmset -g | grep SleepDisabled";
      af = "aerospace fullscreen";

      dev = "devin-insiders --permission-mode smart";
      devc = "devin-insiders --cloud";
      devin-onboard = ''XDG_DATA_HOME="$(mktemp -d)" devin'';
      dev-onboard = ''XDG_DATA_HOME="$(mktemp -d)" cargo run --'';
      dev-max = "XDG_DATA_HOME=$HOME/.devin-max devin-insiders --permission-mode smart";
      dev-free = "XDG_DATA_HOME=$HOME/.devin-free devin-insiders --permission-mode smart";

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

  programs.zoxide.enable = true;

  programs.nh.enable = true;

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
      inherit (colors) separator;
    };
    enable = true;
  };
}
