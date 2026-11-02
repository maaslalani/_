_: {
  xdg.configFile."rex/init.lua".text = ''
    rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })
    rex.bind("ctrl+a>h", "pane.focus.left")
    rex.bind("ctrl+a>j", "pane.focus.down")
    rex.bind("ctrl+a>k", "pane.focus.up")
    rex.bind("ctrl+a>l", "pane.focus.right")
    rex.bind("ctrl+a>'", "pane.split.right")
    rex.bind("ctrl+a>-", "pane.split.down")
    rex.bind("ctrl+a>n", "client.tab.next")
    rex.bind("ctrl+a>p", "client.tab.previous")
  '';
}
