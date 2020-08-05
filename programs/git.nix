{
  enable = true;
  extraConfig = {
    color.ui = true;
    credential.helper = "osxkeychain";
    diff.algorithm = "patience";
    github.user = "maaslalani";
    protocol.version = "2";
    pull.rebase = true;
  };
  userEmail = "maaslalani0@gmail.com";
  userName = "Maas Lalani";
  aliases = {
    hist = "log --graph --pretty='''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''' --all";
    cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d";
  };
}
