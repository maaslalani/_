{
  "..." = "cd ../..";
  "...." = "cd ../../..";

  _ = "cd ~/_";

  ga = "git add";
  gb = "git branch";
  gc = "git commit";
  gco = "git checkout";
  gcom = "git checkout master";
  gcp = "git cherry-pick";
  gcpa = "git cherry-pick --abort";
  gd = "git diff";
  gl = "git pull";
  gm = "git merge";
  gma = "git merge --abort";
  gp = "git push";
  gpf = "git push --force-with-lease";
  gpsup = "git push --set-upstream origin $(git branch --show-current)";
  gr = "git reset";
  grb = "git rebase";
  grba = "git rebase --abort";
  grbc = "git rebase --continue";
  grbi = "git rebase -i";
  grh = "git reset --hard";
  gs = "git status";

  hms = "home-manager switch";

  ls = "exa";
  lsa = "exa -Fla";
  md = "mkdir";

  ta = "tmux attach -t";
  tkss = "tmux kill-session -t";
  tksv = "tmux kill-server";
  tls = "tmux list-sessions";
  tn = "tmux new-session -s";

  tree = "command tree -I 'Godep*' -I 'node_modules*'";
  weather = "curl http://v2.wttr.in";
}
