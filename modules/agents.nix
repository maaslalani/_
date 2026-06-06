{config, ...}: {
  home.file.".agents/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/_/agents/skills";
  home.file.".copilot/agents".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/_/agents/custom";
}
