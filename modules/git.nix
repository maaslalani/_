{pkgs, ...}: let
  email = "maas@lalani.dev";
  name = "Maas Lalani";
  user = "maaslalani";
in {
  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      aliases = {
        clone = "repo clone";
        co = "pr checkout";
      };
      editor = "hx";
    };
  };
  programs.git = {
    package = pkgs.git;
    enable = true;
    lfs.enable = true;
    ignores = [".DS_Store" "result"];
    settings = {
      aliases = {
        cleanup = "!gclean";
        undo = "!gundo";
        hist = "!ghist";
        lo = "!glo";
        open = "!gopen";
      };
      user.email = email;
      user.name = name;
      branch.sort = "-committerdate";
      color.ui = true;
      core.commitGraph = true;
      credential.helper = "osxkeychain";
      delta.navigate = true;
      diff.algorithm = "patience";
      diff.colorMoved = "default";
      fetch.prune = true;
      gc.worktreePruneExpire = "now";
      gc.writeCommitGraph = true;
      github.user = user;
      hub.protocol = "https";
      init.defaultBranch = "main";
      interactive.diffFilter = "delta";
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
  };
}
