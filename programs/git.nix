let
  user = "maaslalani";
  name = "Maas Lalani";
  email = "${user}0@gmail.com";
in {
  enable = true;
  extraConfig = {
    color.ui = true;
    credential.helper = "osxkeychain";
    diff.algorithm = "patience";
    github.user = user;
    protocol.version = "2";
    pull.rebase = true;
  };
  userEmail = email;
  userName = name;
  aliases = {
    hist = "log --graph --pretty='''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''' --all";
    cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d";
    open = "!git config --get remote.origin.url | xargs open";
    lo = "log --oneline -n 10";
  };
}
