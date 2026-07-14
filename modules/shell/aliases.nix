{
  config,
  identity,
  ...
}: {
  programs.zsh.shellAliases = rec {
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
    ghprv = "${ghpv} --web";
    ghpvw = "${ghpv} --web";
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
    gwa = ''
      () {
        if (( $# != 1 )); then
          print -u2 "usage: gwa <branch>"
          return 2
        fi

        git worktree add -b "${identity.githubUser}/$1" "$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)").$1"
      }'';
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
      "nix build $HOME/_#home -o $HOME/_/result"
      "$HOME/_/result/activate"
      sz
    ];
    ncg = "nix-collect-garbage";
    nixd = "sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist && sudo launchctl kickstart -k system/org.nixos.nix-daemon";
    ns = "open https://search.nixos.org/packages\\?channel=unstable";

    # misc
    _ = "tmux switch -t Dotfiles";
    sz = builtins.concatStringsSep " && " [
      "rm -f ${config.xdg.cacheHome}/zsh/zcompdump"
      "unset __HM_ZSH_SESS_VARS_SOURCED"
      "unset __HM_SESS_VARS_SOURCED"
      "source ${config.xdg.configHome}/zsh/.zshrc"
      "(tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null || true)"
    ];
    tn = ''NAME=$(ls -1 $HOME/Developer | gum filter) && SESSION=$(printf %s "$NAME" | tr . -) && (tmux has-session -t "=$SESSION" 2>/dev/null || tmux new-session -d -s "$SESSION" -c "$HOME/Developer/$NAME") && tmux switch-client -t "=$SESSION"'';
    branch = "__branch";
    review = "__review";
    notes = "cd $NOTES";
    todo = "$EDITOR $NOTES/todo.md";

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
}
