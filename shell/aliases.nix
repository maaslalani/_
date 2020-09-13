rec {
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";
  _ = "cd ~/_";

  dstroy = "find . -name '.DS_Store' -type f -delete";

  g = "git";
  ga = "git add";
  gb = "git branch";
  gbc = "${gb} --show-current";
  gc = "git commit";
  gco = "git checkout";
  gcom = "${gco} master";
  gcp = "git cherry-pick";
  gcpa = "${gcp} --abort";
  gd = "git diff";
  gdm = "${gd} master";
  gl = "git pull";
  glo = "git log";
  gm = "git merge";
  gma = "${gm} --abort";
  gp = "git push";
  gpf = "${gp} --force-with-lease";
  gpsup = "${gp} --set-upstream origin `${gbc}`";
  grb = "git rebase";
  grba = "${grb} --abort";
  grbc = "${grb} --continue";
  grbi = "${grb} --interactive";
  grbm = "${grb} master";
  gr = "git reset";
  grh = "${gr} --hard";
  grs = "git restore";
  gs = "git status";
  gss = "${gs} --short";
  gst = "git stash";
  gstp = "${gst} pop";
  gsw = "git switch";
  gswm = "${gsw} master";

  hms = "home-manager switch";

  ls = "exa";
  lsa = "exa -Fla";

  md = "mkdir";

  sz = "source ~/.config/zsh/.zshrc";

  ta = "tmux attach -t";
  tkss = "tmux kill-session -t";
  tksv = "tmux kill-server";
  tls = "tmux list-sessions";
  tn = "tmux new-session -s";
  tns = "tmux new-session -A -s `basename $(pwd)`";

  vi = "/usr/local/bin/nvim/bin/nvim -u /nix/store/jzxdzshcff4frg1gjlxpck1a9f5abya8-vimrc";
  v = "${vi} .";
  vim = "${vi}";

  weather = "curl http://v2.wttr.in";
  wiki = "vim ~/wiki/index.wiki";
}
