{
  config,
  pkgs,
  ...
}: {
  programs.pi-coding-agent = {
    enable = true;
    settings = {
      lastChangelogVersion = pkgs.pi-coding-agent.version;
      theme = "dark/dark";
      defaultProvider = "openai-codex";
      defaultModel = "gpt-5.6-sol";
      hideThinkingBlock = false;
      enabledModels = ["openai-codex/gpt-5.6-sol"];
      defaultThinkingLevel = "max";
      packages = [
        "npm:@dietrichgebert/ponytail"
        "npm:pi-mcp-adapter"
      ];
      doubleEscapeAction = "tree";
      quietStartup = true;
    };
  };
}
