-- Values module

local module = {}

module.terminal = os.getenv('TERMINAL') or 'contour'
module.editor = os.getenv('EDITOR') or 'nvim'
module.browser = os.getenv('BROWSER') or 'firefox'
module.editorCmd = module.terminal .. ' -e ' .. module.editor
module.layoutSuit = AwesomeWM.awful.layout.suid
module.tagLayouts = {
	module.layoutSuit.spiral,
	module.layoutSuit.fair.horizontal,
	module.layoutSuit.floating,
	module.layoutSuit.max.fullscreen,
}

module.initValues = function()

	terminal = module.terminal
	editor = module.editor
	editor_cmd = module.editorCmd
	AwesomeWM.awful.layout.layouts = module.tagLayouts

	local g = AwesomeWM.awful.screen.focused().geometry
	module.screenWidth = g.width
	module.screenHeight = g.height

end

return module
