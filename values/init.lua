local values_m = {}

values_m.awesomeDir = os.getenv("HOME") .. "/.config/awesome"
values_m.dataDir = os.getenv("XDG_DATA_HOME") .. "/awesome"

values_m.restartFile = values_m.dataDir .. "/restart"
values_m.startupFile = values_m.dataDir .. "/startup"
values_m.notesFile = values_m.dataDir .. "/notes"
values_m.mediaFile = values_m.dataDir .. "/media.png"

values_m.terminal = os.getenv("TERMINAL") or "alacritty"
values_m.editor = os.getenv("EDITOR") or "nvim"
values_m.browser = os.getenv("BROWSER") or "firefox"
values_m.fileManager = os.getenv("FILE_MANAGER") or "pcmanfm"
values_m.gmailID = os.getenv("GMAIL_ID") or nil
values_m.outlookID = os.getenv("OUTLOOK_ID") or nil
values_m.githubName = os.getenv("GITHUB_NAME") or nil
values_m.redditName = os.getenv("REDDIT_NAME") or nil

values_m.restorationFile = os.getenv("HOME") .. "/awesomeRestoration"
values_m.editorCmd = values_m.terminal .. " -e " .. values_m.editor
values_m.layoutSuit = AwesomeWM.awful.layout.suit
values_m.tags = {
	{ name = "1", key = "a" },
	{ name = "2", key = "s" },
	{ name = "3", key = "d" },
	{ name = "4", key = "f" },
	{ name = "5", key = "g" },
}
values_m.tagLayouts = {
	values_m.layoutSuit.max.fullscreen,
	values_m.layoutSuit.spiral,
	values_m.layoutSuit.fair.horizontal,
	values_m.layoutSuit.floating,
	values_m.layoutSuit.tile.top,
}

values_m.gmailLink = "https://mail.google.com/"
values_m.outlookLink = "https://outlook.live.com/"
values_m.githubLink = "https://github.com/"
-- values_m.redditLink = 'https://reddit.com/'

values_m.getScript = function(_name)
	return (values_m.awesomeDir .. "/scripts/" .. _name .. ".sh")
end

values_m.batteryLowThreshold = 15
values_m.batteryLowNotified = false
values_m.limitHeadphonesVolume = true

values_m.initValues = function()
	terminal = values_m.terminal
	editor = values_m.editor
	editor_cmd = values_m.editorCmd
	AwesomeWM.awful.layout.layouts = values_m.tagLayouts

	local g = AwesomeWM.awful.screen.focused().geometry
	values_m.screenWidth = g.width
	values_m.screenHeight = g.height
end

return values_m
