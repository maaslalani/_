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

  gri = "git rebase -i";
  grc = "git rebase --continue";
  gra = "git rebase --abort";
}
