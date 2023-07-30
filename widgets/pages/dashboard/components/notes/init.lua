
local notesComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper
local values_sm = AwesomeWM.widgets.pages.values
notesComponent.noteFile = AwesomeWM.values.dataDir .. '/notes.txt'

notesComponent.makeNote = function(_heading, _body, _options)
	_heading = _heading or 'Heading'
	_body = _body or 'Body'
	_options = _options or {}
	_options.padding = _options.padding or 10
	_options.noteBg =  _options.noteBg or AwesomeWM.beautiful.black
	_options.noteHeadingBg = _options.noteHeadingBg or AwesomeWM.beautiful.green
	_options.noteBodyBg = _options.noteBodyBg or nil
	_options.noteFg = _options.noteFg or AwesomeWM.beautiful.white
	_options.noteHeadingFg = _options.noteHeadingFg or AwesomeWM.beautiful.black
	_options.noteBodyFg = _options.noteBodyFg or nil

	local note = {}

	note.heading = AwesomeWM.wibox.widget({
		markup = '<b>' .. _heading .. '</b>',
		font = AwesomeWM.beautiful.pagesFont .. ' 20',
		widget = AwesomeWM.wibox.widget.textbox
	})

	note.headingContent = AwesomeWM.wibox.widget({
		{
			note.heading,
			margins = 5,
			widget = AwesomeWM.wibox.container.margin
		},
		fg = _options.noteHeadingFg or _options.noteFg,
		bg = _options.noteHeadingBg or _options.noteBg,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background
	})

	note.body = AwesomeWM.wibox.widget({
		text = _body,
		font = AwesomeWM.beautiful.pagesFont .. ' 15',
		widget = AwesomeWM.wibox.widget.textbox
	})

	note.bodyContent = AwesomeWM.wibox.widget({
		{
			note.body,
			margins = 5,
			widget = AwesomeWM.wibox.container.margin
		},
		fg = _options.noteBodyFg or _options.noteFg,
		bg = _options.noteBodyBg or _options.noteBg,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background
	})

	note.layout = AwesomeWM.wibox.widget({
		note.headingContent,
		note.bodyContent,
		spacing = _options.padding,
		widget = AwesomeWM.wibox.layout.fixed.vertical
	})

	note.content = AwesomeWM.wibox.widget({
		note.layout,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin
	})

	note.main = AwesomeWM.wibox.widget({
		note.content,
		bg = _options.noteBg,
		fg = _options.noteFg,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background
	})

	return note

end

notesComponent.notes = AwesomeWM.wibox.widget({
	notesComponent.makeNote('Hello world', 'This is a test note').main,
	spacing = 10,
	widget = AwesomeWM.wibox.layout.fixed.vertical
})

notesComponent.scroller = AwesomeWM.wibox.widget({
	notesComponent.notes,
	widget = AwesomeWM.wibox.container.scroll.vertical
})

notesComponent.editButton = helper_sm.makeButton({
	widget = AwesomeWM.wibox.widget({
		text = '󰏫',
		valign = 'center',
		align = 'center',
		font = AwesomeWM.beautiful.nerdFont .. ' 40',
		widget = AwesomeWM.wibox.widget.textbox
	}),

	onClick = function()
		AwesomeWM.awful.spawn(AwesomeWM.values.terminal .. ' -e ' .. AwesomeWM.values.editor .. ' ' .. notesComponent.noteFile)
		AwesomeWM.widgets.pages.dashboard.toggle()
	end,

	overrides = {
		padding = 0,
		buttonShape = AwesomeWM.gears.shape.rounded_rect,
		inactiveButtonBg = AwesomeWM.beautiful.white,
		inactiveButtonBorderColor = AwesomeWM.beautiful.white,
		inactiveButtonFg = AwesomeWM.beautiful.black
	}

})

notesComponent.layout = AwesomeWM.wibox.widget({
	notesComponent.scroller,
	notesComponent.editButton.main,
	spacing = 10,
	widget = AwesomeWM.wibox.layout.fixed.vertical
})

notesComponent.main = AwesomeWM.wibox.widget({
	notesComponent.layout,
	margins = 10,
	widget = AwesomeWM.wibox.container.margin
})

notesComponent.refresh = function()

	local isHeading = true
	local heading = ''
	local counter = 1
	notesComponent.list = {}
	for line in io.lines(notesComponent.noteFile) do
		if line == "" then isHeading = true goto continue end
		if isHeading then
			notesComponent.list[counter] = {heading = line, body = ''}
			heading = line
			isHeading = false
			counter = counter+1
		else
			if notesComponent.list[counter-1].body == '' then
				notesComponent.list[counter-1].body = line
			else
				notesComponent.list[counter-1].body = notesComponent.list[counter-1].body .. '\n' .. line
			end
		end
		::continue::
	end

	notesComponent.notes:reset()

	for index, note in pairs(notesComponent.list) do
		notesComponent.notes:add(notesComponent.makeNote(note.heading, note.body, {
		}).main)

	end
end

return notesComponent
