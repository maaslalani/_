{
  config,
  pkgs,
  ...
}: let
  logs = "${config.home.homeDirectory}/Library/Logs/kache";
in {
  xdg.configFile."kache/config.toml".text = ''
    [cache]
    auto_recover_targets = true
    local_max_size = "300GiB"
    cache_executables = true
    explain_miss = true
  '';

  launchd.agents.kache = {
    enable = true;
    config = {
      Label = "ninja.kunobi.kache";
      ProgramArguments = ["${pkgs.kache}/bin/kache" "daemon" "run"];
      EnvironmentVariables.KACHE_LOG = "kache=info";
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "${logs}/out.log";
      StandardErrorPath = "${logs}/err.log";
      ThrottleInterval = 5;
    };
  };
}
