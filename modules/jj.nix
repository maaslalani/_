{...}: let
  email = "maas@lalani.dev";
  name = "Maas Lalani";
in {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        inherit email name;
      };
      ui = {
        default-command = "log";
        diff-editor = ":builtin";
        pager = "less -FRX";
      };
      aliases = {
        l = ["log" "-r" "@ | ancestors(@, 10) | trunk()..@-"];
        d = ["diff"];
        m = ["describe"];
        s = ["status"];
      };
      revset-aliases = {
        "mine()" = "ancestors(@ ~ trunk(), 2)";
      };
      template-aliases = {
        "format_short_id(id)" = "id.shortest(8)";
      };
      colors."diff token".underline = false;
    };
  };
}
