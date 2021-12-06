{ config, pkgs, libs, ... }:
let
  email = "maas@lalani.dev";
  name = "Maas Lalani";
  user = "maaslalani";
in
{
  programs.git = {
    enable = true;
    extraConfig = {
      branch.sort = "-committerdate";
      color.ui = true;
      commit.gpgsign = true;
      core.commitGraph = true;
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      fetch.prune = true;
      gc.writeCommitGraph = true;
      github.user = user;
      gpg.program = "${pkgs.gnupg}/bin/gpg2";
      hub.protocol = "https";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      protocol.version = "2";
      pull.rebase = true;
    };
    signing = {
      gpgPath = "${pkgs.gnupg}/bin/gpg2";
      key = "B46091A89FBCE2E080816EB8BB664307626967AC";
      signByDefault = true;
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = "Nord";
        line-numbers = true;
        line-numbers-zero-style = "#4C566A";
      };
    };
    userEmail = email;
    userName = name;
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|main\\|master\\|develop' | xargs -n 1 git branch -d";
      hist = "log --pretty=format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\" --date=short";
      lo = "log --oneline -n 20";
      open = "!git config --get remote.origin.url | xargs open";
      undo = "reset HEAD~1 --mixed";
    };
  };
}
