-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Disable font ligatures (they annoy me)
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Also hide the tab bar. Not used normally
config.hide_tab_bar_if_only_one_tab = true

-- By default: the terminal prompts when closing
config.window_close_confirmation = 'NeverPrompt'

-- custom keyboard bindings (similar to work tmux)
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Split panes
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Pane navigation
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  -- Pane focus / defocus
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
}

-- startup layout
wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	
	-- quad terminal split
	local top = pane:split { direction = 'Top', size = 0.5 }
	top:split { direction = 'Left', size = 0.5 }
	pane:split { direction = 'Left', size = 0.5 }
end)

-- and finally, return the configuration to wezterm
return config