hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.80 }
hs.alert.defaultStyle.padding = 22
hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0.25 }
hs.alert.defaultStyle.strokeWidth = 5
hs.alert.defaultStyle.textColor = { white = 1, alpha = 0.8 }
hs.alert.defaultStyle.textFont = "Menlo"
hs.alert.defaultStyle.textSize = 18

hs.alert.show('Hammerspoon Loaded', 1)

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall:andUse('HSearch')

hs.window.animationDuration = 0
hs.grid.setGrid('6x4')
hs.grid.ui.cellColor = {0,0,0,0.25}
hs.grid.ui.cellStrokeColor = {0.2,0.2,0.2}
hs.grid.ui.cellStrokeWidth = 5
hs.grid.ui.cyclingHighlightColor = {0.2,0.2,0.2,0.5}
hs.grid.ui.cyclingHighlightStrokeColor = {0.2,0.2,0.2,1}
hs.grid.ui.highlightColor = {0.2,0.2,0.2,0.5}
hs.grid.ui.highlightStrokeColor = {0.8,0.8,0.8,1}
hs.grid.ui.highlightStrokeWidth = 10
hs.grid.ui.selectedColor = {0.6,0.6,0.6,0.2}
hs.grid.ui.textColor = {1,1,1}
hs.grid.ui.textSize = 150

function launchOrFocusCallback(application)
  return function()
    hs.application.launchOrFocus(application)
  end
end

local menu = {
  f = { name = 'Focus', action = hs.hints.windowHints },
  g = { name = 'Grid', action = hs.grid.show },
  r = { name = 'Reload', action = hs.reload },
  s = { name = 'Search', action = spoon.HSearch.toggleShow },
  a = {
    name = 'Applications',
    a = { name = 'Alacritty', action = launchOrFocusCallback('Alacritty') },
    b = { name = 'Brave', action = launchOrFocusCallback('Brave Browser') },
    c = { name = 'Calendar', action = launchOrFocusCallback('Calendar') },
    p = { name = '1Password', action = launchOrFocusCallback('1Password 7') },
    r = { name = 'Reminders', action = launchOrFocusCallback('Reminders') },
    s = { name = 'Slack', action = launchOrFocusCallback('Slack') },
    t = { name = 'Tuple', action = launchOrFocusCallback('Tuple') },
    n = { name = 'Notes', action = launchOrFocusCallback('Notes') },
  },
  w = {
    name = 'Window',
    h = { name = 'Left', repeatable = true, action = hs.window.moveOneScreenWest },
    j = { name = 'Down', repeatable = true, action = hs.window.moveOneScreenSouth },
    k = { name = 'Up', repeatable = true, action = hs.window.moveOneScreenNorth },
    l = { name = 'Right', repeatable = true, action = hs.window.moveOneScreenEast },
  },
}

start = hs.hotkey.modal.new({'cmd'}, 'space')

function setup(modal, menu)
  function modal:exited() hs.alert.closeAll() end
  modal:bind({}, 'escape', function() modal:exit() end)

  local display = {}
  for k, v in pairs(menu) do
    if type(v) == 'table' then
      display[#display+1] = k .. '   ' .. v.name
      local action = {}
      if v.action ~= nil then
        action = v.action
      else
        local submenu = hs.hotkey.modal.new()
        setup(submenu, v)
        action = submenu.enter
      end
      modal:bind({}, k, function()
        if v.repeatable ~= true then
          modal:exit()
        end
        action()
      end)
    end
  end
  function modal:entered()
    hs.alert.closeAll()
    hs.alert(table.concat(display, '\n'), true) 
  end
end

setup(start, menu)
