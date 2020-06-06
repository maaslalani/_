rec {
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";

  _ = "cd ~/_";

  dstroy = "fd -H .DS_Store | xargs sudo rm";

  ga = "git add";
  gb = "git branch";
  gc = "git commit";

  gco = "git checkout";
  gcom = "git checkout master";

  gcp = "git cherry-pick";
  gcpa = "git cherry-pick --abort";

  gd = "git diff";
  gdm = "git diff master";

  gl = "git pull";

  gm = "git merge";
  gma = "git merge --abort";

  gp = "git push";
  gpf = "git push --force-with-lease";
  gpsup = "git push --set-upstream origin $(git branch --show-current)";

  grb = "git rebase";
  grbm = "git rebase master";
  grba = "git rebase --abort";
  grbc = "git rebase --continue";
  grbi = "git rebase -i";

  gr = "git reset";
  grh = "git reset --hard";

  gs = "git status";

  glo = "git log";

  gsw = "git switch";
  gswm = "git switch master";
  gswf = "git branch | fzf | xargs git switch";

  grs = "git restore";

  hms = "home-manager switch";
  ncg = "nix-collect-garbage";

  ls = "exa";
  lsa = "exa -Fla";
  md = "mkdir";

  ta = "tmux attach -t";
  tkss = "tmux kill-session -t";
  tksv = "tmux kill-server";
  tls = "tmux list-sessions";
  tn = "tmux new-session -s";

  kcx = "kubectl config current-context";
  kcxa = "kubectl config get-contexts -o name";
  kchcx = "${kcxa} | fzf | xargs kubectl config use-context";

  kns = "kubectl config view --minify --output=jsonpath='{..namespace}'";
  knsa = "kubectl get namespaces -o=custom-columns=NAME:.metadata.name --no-headers";
  kchns = "${knsa} | fzf | xargs -I{} kubectl config set-context --current --namespace={}";

  tree = "command tree -I 'Godep*' -I 'node_modules*'";
  weather = "curl http://v2.wttr.in";
  v = "vim .";

  sz = "source ~/.zshrc";
}
