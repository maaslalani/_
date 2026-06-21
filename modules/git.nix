{
  pkgs,
  identity,
  ...
}: {
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
      user.email = identity.email;
      user.name = identity.name;
      branch.sort = "-committerdate";
      color.ui = true;
      core.commitGraph = true;
      core.pager = "hunk pager";
      credential.helper = "osxkeychain";
      delta.navigate = true;
      diff.algorithm = "patience";
      diff.colorMoved = "default";
      fetch.prune = true;
      gc.worktreePruneExpire = "now";
      gc.writeCommitGraph = true;
      github.user = identity.githubUser;
      hub.protocol = "https";
      init.defaultBranch = "main";
      interactive.diffFilter = "hunk";
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
