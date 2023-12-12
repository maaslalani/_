{
  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        clone = "repo clone";
        co = "pr checkout";
      };
      editor = "$EDITOR";
    };
  };
}
