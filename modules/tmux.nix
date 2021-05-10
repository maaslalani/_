{ config, pkgs, libs, ... }:
with builtins; let
  config = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));
  attrsToConfig = p: config (n: v: ("set -g ${p}${n} ${v}"));
  bindToConfig = config (n: v: ("bind ${n} ${v}"));

  settings = {
    default-terminal = "'xterm-256color'";
    mouse = "on";
    terminal-overrides = "',xterm-256color:Tc'";
  };

  pane = {
    border-style = "fg=black,bg=default";
    active-border-style = "fg=black,bg=default";
  };

  status = {
    style = "bg=default";
    right-style = "bg=default,fg=white";
    justify = "left";
    right = "'  %H:%M  '";
    left = "''";
  };

  window = {
    status-style = "fg=white,bg=default";
    status-current-style = "fg=cyan,bg=default";
    status-current-format = "' #I:#W '";
    status-format = "' #I:#W '";
  };

  message = {
    command-style = "fg=white,bg=default";
    style = "fg=cyan,bg=default";
  };

  mode.style = "fg=cyan,bg=colour0";

  currentPath = "-c \"#{pane_current_path}\"";

  binds = {
    "|" = "split-window -h ${currentPath}";
    "-" = "split-window ${currentPath}";
    "c" = "new-window ${currentPath}";
    "=" = "set-window-option synchronize-panes";
    "C-a" = "send-prefix";
  };

in
{
  programs.tmux = {
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    newSession = false;
    secureSocket = false;
    sensibleOnTop = false;
    shortcut = "a";
    terminal = "xterm-256color";
    extraConfig = ''
      ${attrsToConfig "" settings}
      ${attrsToConfig "pane-" pane}
      ${attrsToConfig "window-" window}
      ${attrsToConfig "message-" message}
      ${attrsToConfig "status-" status}
      ${attrsToConfig "mode-" mode}
      ${bindToConfig binds}
    '';
  };
}
