-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	-- Font Configuration
	font = wezterm.font("Hack Nerd Font"),
	font_size = 11.0,

	default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-l" },
	launch_menu = {
		{
			label = "Git Bash",
			args = { "C:\\Program Files\\Git\\bin\\bash.exe", "-l" },
		},
		{
			label = "CMD",
			args = { "cmd.exe" },
		},
		{
			label = "PowerShell",
			args = { "powershell.exe" },
		},
		{
			label = "VS 2026 x64 Command Prompt",
			args = {
				"cmd.exe",
				"/k",
				"C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\VC\\Auxiliary\\Build\\vcvarsall.bat",
				"x64",
			},
		},
	},
	color_scheme = "catppuccin-mocha",
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = false,
	window_decorations = "RESIZE",
	leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{
			key = "t",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "Space",
			mods = "LEADER",
			action = act.ShowLauncher,
		},
	},
}

-- Finally, return the configuration to wezterm:
return config
