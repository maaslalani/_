hs.hotkey.bind({'cmd', 'ctrl'}, 'R', hs.reload)

hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.80 }
hs.alert.defaultStyle.padding = 22
hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0.25 }
hs.alert.defaultStyle.strokeWidth = 5
hs.alert.defaultStyle.textColor = { white = 1, alpha = 0.8 }
hs.alert.defaultStyle.textFont = "Menlo"
hs.alert.defaultStyle.textSize = 18

hs.alert.show('Hammerspoon Loaded', 1)

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

local menu = {
  a = {
    name = 'Applications',
    a = {
      name = 'Alacritty',
      action = function()
        hs.application.launchOrFocus('Alacritty')
        hs.alert('Open Alacritty')
      end
    },
    b = {
      name = 'Brave',
      action = function()
        hs.application.launchOrFocus('Brave Browser')
        hs.alert('Open Brave Browser')
      end
    },
    c = {
      name = 'Calendar',
      action = function()
        hs.application.launchOrFocus('Calendar')
        hs.alert('Open Calendar')
      end
    },
    p = {
      name = '1Password',
      action = function()
        hs.application.launchOrFocus('1Password 7')
        hs.alert('Open 1Password')
      end
    },
    s = {
      name = 'Slack',
      action = function()
        hs.application.launchOrFocus('Slack')
        hs.alert('Open Slack')
      end
    },
  },
  g = {
    name = 'Grid',
    action = function()
      hs.grid.show()
    end
  },
  f = {
    name = 'Focus',
    action = function()
      hs.hints.windowHints()
    end,
  },
  w = {
    name = 'Window',
    h = {
      name = 'Left',
      repeatable = true,
      action = function()
        hs.window:moveOneScreenWest()
      end
    },
    j = {
      name = 'Down',
      repeatable = true,
      action = function()
        hs.window:moveOneScreenSouth()
      end
    },
    k = {
      name = 'Up',
      repeatable = true,
      action = function()
        hs.window:moveOneScreenNorth()
      end
    },
    l = {
      name = 'Right',
      repeatable = true,
      action = function()
        hs.window:moveOneScreenEast()
      end
    },
  }
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
        action = function()
          submenu:enter()
        end
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

hs.loadSpoon('SpoonInstall')
