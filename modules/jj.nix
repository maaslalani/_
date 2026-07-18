{
  pkgs,
  identity,
  ...
}: {
  programs.jujutsu = {
    enable = true;
    package = pkgs.jujutsu;
    settings = {
      user = {
        email = identity.email;
        name = identity.name;
      };
      ui = {
        default-command = "log";
        pager = ["hunk" "pager"];
      };
      git.push-new-bookmarks = true;
    };
  };
}
