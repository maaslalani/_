{pkgs, ...}: let
  email = "maas@lalani.dev";
  name = "Maas Lalani";
  user = "maaslalani";
in {
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [".DS_Store" "result"];
    extraConfig = {
      branch.sort = "-committerdate";
      color.ui = true;
      commit.gpgsign = true;
      core.commitGraph = true;
      core.pager = "delta";
      credential.helper =
        if pkgs.stdenv.isDarwin
        then "osxkeychain"
        else "cache";
      delta.navigate = true;
      diff.algorithm = "patience";
      diff.colorMoved = "default";
      fetch.prune = true;
      gc.worktreePruneExpire = "now";
      gc.writeCommitGraph = true;
      github.user = user;
      hub.protocol = "https";
      init.defaultBranch = "main";
      interactive.diffFilter = "delta --color-only";
      merge.conflictstyle = "diff3";
      protocol.version = "2";
      pull.rebase = true;
      pull.twohead = "ort";
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
    signing = {
      key = "AECD51CD3C3A50BB9AA21C685A6ED5CBF1A0A000";
      signByDefault = true;
    };
    userEmail = email;
    userName = name;
    aliases = {
      cleanup = "!gclean";
      undo = "!gundo";
      hist = "!ghist";
      lo = "!glo";
      open = "!gopen";
    };
  };
}
