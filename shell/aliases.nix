rec {
  "..."   = "cd ../..";
  "...."  = "cd ../../..";
  "....." = "cd ../../../..";
  _       = "cd ~/_";

  dstroy  = "fd -H .DS_Store | xargs sudo rm";

  ga    = "git add";
  gb    = "git branch";
  gc    = "git commit";
  gco   = "git checkout";
  gcom  = "git checkout master";
  gcp   = "git cherry-pick";
  gcpa  = "git cherry-pick --abort";
  gd    = "git diff";
  gdm   = "git diff master";
  gl    = "git pull";
  glo   = "git log";
  gm    = "git merge";
  gma   = "git merge --abort";
  gp    = "git push";
  gpf   = "git push --force-with-lease";
  gpsup = "git push --set-upstream origin $(git branch --show-current)";
  gr    = "git reset";
  grb   = "git rebase";
  grba  = "git rebase --abort";
  grbc  = "git rebase --continue";
  grbi  = "git rebase -i";
  grbm  = "git rebase master";
  grh   = "git reset --hard";
  grs   = "git restore";
  gs    = "git status";
  gss   = "git status --short";
  gst   = "git stash";
  gstp  = "git stash pop";
  gsw   = "git switch";
  gswf  = "git branch | fzf | xargs git switch";
  gswm  = "git switch master";

  hms   = "home-manager switch";

  ls    = "exa";
  lsa   = "exa -Fla";

  md = "mkdir";

  n   = "ntbk";
  ng  = "ntbk grep";
  nls = "ntbk list";
  no  = "ntbk open";
  ns  = "ntbk search";

  ra = "reminders add";
  rc = "reminders complete";
  rl = "reminders list";

  sz = "source ~/.config/zsh/.zshrc";

  ta   = "tmux attach -t";
  tkss = "tmux kill-session -t";
  tksv = "tmux kill-server";
  tls  = "tmux list-sessions";
  tn   = "tmux new-session -s";
  tns  = "tmux new-session -A -s `basename $(pwd)`";

  todo = "ntbk open tasks";

  tree = "command tree -I 'Godep*' -I 'node_modules*'";

  v   = "nvim .";
  vi  = "nvim";
  vim = "nvim";

  weather = "curl http://v2.wttr.in";
}
