hs.hotkey.bind({'cmd', 'ctrl'}, 'R', hs.reload)

hs.alert.defaultStyle.radius = 2
hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.75 }
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0.25 }
hs.alert.defaultStyle.strokeWidth = 5
hs.alert.defaultStyle.textColor = { white = 1, alpha = 0.8 }
hs.alert.defaultStyle.textSize = 18
hs.alert.defaultStyle.textFont = "Menlo"
hs.alert.defaultStyle.padding = 18

hs.alert.show('Hammerspoon Loaded', 1)

local menu = {
  a = {
    name = 'Applications',
    a = {
      name = 'Alacritty',
      action = function()
        hs.alert('Open Alacritty')
      end
    },
    b = {
      name = 'Brave Browser',
      action = function()
        hs.alert('Open Brave Browser')
      end
    },
    c = {
      name = 'Calendar',
      action = function()
        hs.alert('Open Calendar')
      end
    },
    p = {
      name = '1Password',
      action = function()
        hs.alert('Open 1Password')
      end
    },
    s = {
      name = 'Slack',
      action = function()
        hs.alert('Open Slack')
      end
    },
  },
  g = {
    name = 'Grid',
    action = function()
      hs.alert('Open Grid')
    end
  },
  w = {
    name = 'Window',
    h = {
      name = 'Left',
      action = function()
        hs.alert('H')
      end
    },
    j = {
      name = 'Down',
      action = function()
        hs.alert('J')
      end
    },
    k = {
      name = 'Up',
      action = function()
        hs.alert('K')
      end
    },
    l = {
      name = 'Right',
      action = function()
        hs.alert('L')
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
      modal:bind({}, k, function() modal:exit() action() end)
    end
  end
  function modal:entered()
    hs.alert.closeAll()
    hs.alert(table.concat(display, '\n'), true) 
  end
end

setup(start, menu)

hs.loadSpoon('SpoonInstall')
