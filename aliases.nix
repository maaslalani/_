{
  _ = "cd ~/_";

  hms = "home-manager switch";

  tree = "command tree -I 'Godep*' -I 'node_modules*'";

  weather = "curl http://v2.wttr.in";

  gb = "git branch";
  gco = "git checkout";
  gcom = "git checkout master";

  ga = "git add";
  gc = "git commit";
  gr = "git reset";
  grh = "git reset --hard";

  gp = "git push";
  gpf = "git push --force-with-lease";
  gl = "git pull";
  gd = "git diff";
  gs = "git status";

  gm = "git merge";
  gma = "git merge --abort";

  gcp = "git cherry-pick";
  gcpa = "git cherry-pick --abort";

  grb = "git rebase";
  grbi = "git rebase -i";
  grbc = "git rebase --continue";
  grba = "git rebase --abort";

  gpsup = "git push --set-upstream origin $(git branch --show-current)";

  tksv = "tmux kill-server";
  tkss = "tmux kill-session -t";
  ta = "tmux attach -t";
  tls = "tmux list-sessions";
  tn = "tmux new-session -s";

  md = "mkdir";
  lsa = "ls -a";

  "..." = "cd ../..";
  "...." = "cd ../../..";
}
