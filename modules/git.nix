{identity, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      version = "1";
      aliases = {
        clone = "repo clone";
        co = "pr checkout";
      };
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [".DS_Store" "result"];
    settings = {
      user = {inherit (identity) email name;};
      branch.sort = "-committerdate";
      checkout.defaultRemote = "origin";
      color.ui = true;
      core.pager = "hunk pager";
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      diff.colorMoved = "default";
      fetch.prune = true;
      gc.worktreePruneExpire = "now";
      init.defaultBranch = "main";
      interactive.diffFilter = "hunk";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
    signing = {
      key = identity.signingKey;
      signByDefault = false;
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {inherit (identity) email name;};
      ui = {
        default-command = "log";
        pager = ["hunk" "pager"];
      };
      git.push-new-bookmarks = true;
    };
  };
}
