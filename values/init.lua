-- Values module

local module = {}

module.terminal = os.getenv('TERMINAL') or 'contour'
module.editor = os.getenv('EDITOR') or 'nvim'
module.browser = os.getenv('BROWSER') or 'firefox'
module.editorCmd = module.terminal .. ' -e ' .. module.editor

module.initValues = function()

	terminal = module.terminal
	editor = module.editor
	editor_cmd = module.editorCmd

	local g = AwesomeWM.awful.screen.focused().geometry
	module.screenWidth = g.width
	module.screenHeight = g.height

end

return module
