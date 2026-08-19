{pkgs, ...}: {
  programs.pi-coding-agent = {
    enable = true;
    settings = {
      lastChangelogVersion = pkgs.pi-coding-agent.version;
      theme = "dark/dark";
      defaultProvider = "openai-codex";
      defaultModel = "gpt-5.6-sol";
      enabledModels = ["openai-codex/gpt-5.6-sol"];
      defaultThinkingLevel = "max";
      packages = [
        "npm:@dietrichgebert/ponytail"
        "npm:pi-mcp-adapter"
      ];
      quietStartup = false;
    };
  };

  home.file.".pi/agent/extensions/startup-art.ts".text = ''
    import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

    const logo = [
      "████████████",
      "████████████",
      "████    ████",
      "████    ████",
      "████████    ████",
      "████████    ████",
      "████        ████",
      "████        ████",
    ];

    export default function (pi: ExtensionAPI) {
      pi.on("session_start", (_event, ctx) => {
        if (ctx.mode !== "tui") return;
        ctx.ui.setHeader((_tui, theme) => ({
          render: (width) => logo.map((line) => theme.fg("accent", line.slice(0, width))),
          invalidate() {},
        }));
      });
    }
  '';
}
