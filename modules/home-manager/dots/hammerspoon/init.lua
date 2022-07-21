hyper                = { "cmd", "alt", "ctrl" }
shift_hyper          = { "cmd", "alt", "ctrl", "shift" }
ctrl_cmd             = { "cmd", "ctrl" }
ctrl_cmd_shift       = { "cmd", "ctrl", "shift" }
mac_cmd              = { "cmd" }
cmd_opt              = { "cmd", "alt" }
opt                  = { "alt" }
opt_shift            = { "alt", "shift" }
shifted_key_versions = {
  A = "a",
  B = "b",
  C = "c",
  D = "d",
  E = "e",
  F = "f",
  G = "g",
  H = "h",
  I = "i",
  J = "j",
  K = "k",
  L = "l",
  M = "m",
  N = "n",
  O = "o",
  P = "p",
  Q = "q",
  R = "r",
  S = "s",
  T = "t",
  U = "u",
  V = "v",
  W = "w",
  X = "x",
  Y = "y",
  Z = "z",
  ["{"] = "[",
  ["}"] = "]"
}


function get_shifted_key_if_applicable(key)
  return shifted_key_versions[key] or key
end

function handle_bindspec_for_shifted_keys(modifier, key)
  local shifted_key = get_shifted_key_if_applicable(key)
  local concat_modifier
  if shifted_key ~= key then
    concat_modifier = hs.fnutils.concat({ "shift" }, modifier)
  else
    concat_modifier = modifier
  end
  -- print(hs.inspect(modifier),hs.inspect(key),hs.inspect(concat_modifier),hs.inspect(shifted_key))
  return { concat_modifier, shifted_key };
end

function bulk_keybind(modifier, keybindings)
  for key, func in pairs(keybindings) do
    hs.hotkey.bindSpec(handle_bindspec_for_shifted_keys(modifier, key), func)
  end
end

function MoveToScreen(direction)
  local cwin = hs.window.focusedWindow()
  if cwin then
    local is_full_screen = cwin:isFullScreen()
    if is_full_screen then
      cwin:setFullScreen(false)
      hs.timer.usleep(999999)
    end
    local cscreen = cwin:screen()
    if direction == "up" then
      cwin:moveOneScreenNorth()
    elseif direction == "down" then
      cwin:moveOneScreenSouth()
    elseif direction == "left" then
      cwin:moveOneScreenWest()
    elseif direction == "right" then
      cwin:moveOneScreenEast()
    elseif direction == "next" then
      cwin:moveToScreen(cscreen:next())
    else
      hs.alert.show("Unknown direction: " .. direction)
    end
    if is_full_screen then
      -- a sleep is required to let the window manager register the new state,
      -- otherwise the follow-up minimize() call doesn't work
      hs.timer.doAfter(0.6, function()
        cwin:setFullScreen(true)
      end)
    end
  else
    hs.alert.show("No focused window!")
  end
end

-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
--   hs.reload()
-- end)
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("EmmyLua")
hsupervisor_keys = { opt_shift, "space" }
hshelp_keys = { opt_shift, "/" }
spoon.SpoonInstall:andUse("ModalMgr")
-- spoon.SpoonInstall:andUse("ReloadConfiguration",{start=true})

---@param mouse_follows_focus spoon.MouseFollowsFocus
spoon.SpoonInstall:andUse("MouseFollowsFocus", { start = true, fn = function(mouse_follows_focus)
  ---@type spoon.ModalMgr
  local modal_mgr = spoon.ModalMgr
  modal_mgr:new("MouseFollowsFocus")
  ---@type hs.hotkey.modal
  local cmodal = modal_mgr.modal_list["MouseFollowsFocus"]
  ---@type hs.hotkey.modal
  local supervisor = modal_mgr.supervisor
  cmodal:bind('', 'escape', 'Exit', function() modal_mgr:deactivate({ "MouseFollowsFocus" }) supervisor:exit() end)
  cmodal:bind('', 'M', 'Start mouse follow focus',
    function() mouse_follows_focus:start() hs.alert.show("Mouse Follows Focus Started") supervisor:exit() end)
  cmodal:bind('shift', 'M', 'Stop mouse follow focus',
    function() mouse_follows_focus:stop() hs.alert.show("Mouse Follows Focus Stopped") supervisor:exit() end)
  cmodal:bind('shift', '/', 'Cheatsheet', function() modal_mgr:toggleCheatsheet() end)
  supervisor:bind('', "m", "Enter Mouse Focus Management", function()
    modal_mgr:deactivateAll()
    modal_mgr:activate({ "MouseFollowsFocus" }, nil, true)
  end)
end })

spoon.SpoonInstall:andUse("AppLauncher", {
  config = {
    modifiers = opt
  },
  hotkeys = {
    ['1'] = "Firefox",
    ['2'] = "Visual Studio Code",
    ['4'] = "Whatsapp",
    ['5'] = "WezTerm",
    ['0'] = "Spotify"
  }
})

spoon.SpoonInstall:andUse("KSheet", {
  ---@param ksheet spoon.KSheet
  fn = function(ksheet)
    ---@type spoon.ModalMgr
    local modal_mgr = spoon.ModalMgr
    modal_mgr:new("Keybinds")
    ---@type hs.hotkey.modal
    local cmodal = modal_mgr.modal_list["Keybinds"]
    ---@type hs.hotkey.modal
    local supervisor = modal_mgr.supervisor
    cmodal:bind('', 'escape', 'Exit', function() modal_mgr:deactivate({ "Keybinds" }) supervisor:exit() end)
    cmodal:bind('', 'k', 'show ksheet', function() ksheet:toggle() end)
    cmodal:bind('shift', '/', 'Cheatsheet', function() modal_mgr:toggleCheatsheet() end)
    supervisor:bind('', "k", "Enter keybindings cheatsheet", function()
      modal_mgr:deactivateAll()
      modal_mgr:activate({ "Keybinds" }, nil, true)
    end)
  end
})

spoon.SpoonInstall:andUse("HSKeybindings", {
  ---@param hs_keybindings spoon.HSKeybindings
  fn = function(hs_keybindings)
    ---@type spoon.ModalMgr
    local modal_mgr = spoon.ModalMgr
    if modal_mgr.modal_list["Keybinds"] == nil then
      modal_mgr:new("Keybinds")
    end
    ---@type hs.hotkey.modal
    local cmodal = modal_mgr.modal_list["Keybinds"]
    cmodal:bind('', 's', 'show keybindings', function() hs_keybindings:show()end)
    cmodal:bind('', 'h', 'hide keybindings', function() hs_keybindings:hide() end)
  end,
  disable = true
})


---@param win_win spoon.WinWin
spoon.SpoonInstall:andUse("WinWin", { fn = function(win_win)
  ---@type spoon.ModalMgr
  local modal_mgr = spoon.ModalMgr
  modal_mgr:new("WindowManager")
  ---@type hs.hotkey.modal
  local cmodal = modal_mgr.modal_list["WindowManager"]
  ---@type hs.hotkey.modal
  local supervisor = modal_mgr.supervisor
  cmodal:bind('', 'escape', 'Exit', function() modal_mgr:deactivate({ "WindowManager" }) supervisor:exit() end)
  cmodal:bind('shift', '/', 'Cheatsheet', function() modal_mgr:toggleCheatsheet() end)
  cmodal:bind('', '7', 'NW', function() win_win:moveAndResize('cornerNW') end)
  cmodal:bind('', '8', 'N', function() win_win:moveAndResize('halfup') end)
  cmodal:bind('', '9', 'NE', function() win_win:moveAndResize('cornerNE') end)

  cmodal:bind('', '4', 'W', function() win_win:moveAndResize('halfleft') end)
  cmodal:bind('', '5', 'C', function() win_win:moveAndResize('center') end)
  cmodal:bind('', '6', 'E', function() win_win:moveAndResize('halfright') end)

  cmodal:bind('', '1', 'SW', function() win_win:moveAndResize('cornerSW') end)
  cmodal:bind('', '2', 'S', function() win_win:moveAndResize('halfdown') end)
  cmodal:bind('', '3', 'SE', function() win_win:moveAndResize('cornerSE') end)
  cmodal:bind('', '0', 'maximize', function() win_win:moveAndResize('maximize') end)

  cmodal:bind('', 'F', 'fullscreen', function() win_win:moveAndResize('fullscreen') end)

  cmodal:bind('', 'H', 'left', function() win_win:stepResize('left') end)
  cmodal:bind('', 'J', 'down', function() win_win:stepResize('down') end)
  cmodal:bind('', 'K', 'up', function() win_win:stepResize('up') end)
  cmodal:bind('', 'l', 'right', function() win_win:stepResize('right') end)

  cmodal:bind('shift', 'H', 'move left', function() win_win:stepMove('left') end)
  cmodal:bind('shift', 'J', 'move down', function() win_win:stepMove('down') end)
  cmodal:bind('shift', 'K', 'move up', function() win_win:stepMove('up') end)
  cmodal:bind('shift', 'L', 'move right', function() win_win:stepMove('right') end)

  cmodal:bind('', '[', 'left screen', function() MoveToScreen('left') end)
  cmodal:bind('', ']', 'right screen', function() MoveToScreen('right') end)
  supervisor:bind('', "w", "Enter Window Management", function()
    modal_mgr:deactivateAll()
    modal_mgr:activate({ "WindowManager" }, nil, true)
  end)
end })
spoon.SpoonInstall:andUse("ArrangeDesktop")

-- spoon.SpoonInstall:andUse("Seal", { hotkeys = { toggle = { mac_cmd , "space" } },
--     fn = function(s)
--             s:loadPlugins({"apps", "calc", "safari_bookmarks"})
--         end,
--     start = true,
-- })
-- TODO: Add a keybinding for this

hs.alert.show("Config loaded")
