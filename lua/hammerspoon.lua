hs.hotkey.bind({'cmd', 'ctrl'}, 'R', hs.reload)
hs.alert('Hammerspoon Started')

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall:andUse('AppLauncher', {
  hotkeys = {
    a = 'Alacritty',
    b = 'Brave Browser',
    c = 'Calendar',
    p = '1Password 7',
    s = 'Slack',
  },
  config = {
    modifiers = {'cmd', 'ctrl'},
  },
})
spoon.SpoonInstall:andUse('WindowGrid', {
  config = {
    gridGeometries = { { '6x4' } },
  },
  hotkeys = {
    show_grid = { {'cmd', 'ctrl'}, 't' },
  },
})
