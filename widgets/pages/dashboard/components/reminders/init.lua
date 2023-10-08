local remindersComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper
local values_sm = AwesomeWM.widgets.pages.values
remindersComponent.reminderFile = AwesomeWM.values.remindersFile

remindersComponent.makeReminder = function(_heading, _body, _options)
	_heading = _heading or "Heading"
	_body = _body or "Body"
	_options = _options or {}
	_options.padding = _options.padding or 10
	_options.noteBg = _options.noteBg or AwesomeWM.beautiful.gray
	_options.noteHeadingBg = _options.noteHeadingBg or AwesomeWM.beautiful.green
	_options.noteBodyBg = _options.noteBodyBg or nil
	_options.noteFg = _options.noteFg or AwesomeWM.beautiful.white
	_options.noteHeadingFg = _options.noteHeadingFg or AwesomeWM.beautiful.black
	_options.noteBodyFg = _options.noteBodyFg or nil

	local note = {}

	note.heading = AwesomeWM.wibox.widget({
		markup = "<b>" .. _heading .. "</b>",
		font = AwesomeWM.beautiful.pagesFont .. " 20",
		widget = AwesomeWM.wibox.widget.textbox,
	})

	note.headingContent = AwesomeWM.wibox.widget({
		{
			note.heading,
			margins = 5,
			widget = AwesomeWM.wibox.container.margin,
		},
		fg = _options.noteHeadingFg or _options.noteFg,
		bg = _options.noteHeadingBg or _options.noteBg,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background,
	})

	note.body = AwesomeWM.wibox.widget({
		text = _body,
		font = AwesomeWM.beautiful.pagesFont .. " 15",
		widget = AwesomeWM.wibox.widget.textbox,
	})

	note.bodyContent = AwesomeWM.wibox.widget({
		{
			note.body,
			margins = 5,
			widget = AwesomeWM.wibox.container.margin,
		},
		fg = _options.noteBodyFg or _options.noteFg,
		bg = _options.noteBodyBg or _options.noteBg,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background,
	})

	note.layout = AwesomeWM.wibox.widget({
		note.headingContent,
		note.bodyContent,
		spacing = _options.padding,
		widget = AwesomeWM.wibox.layout.fixed.vertical,
	})

	note.content = AwesomeWM.wibox.widget({
		note.layout,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin,
	})

	note.main = AwesomeWM.wibox.widget({
		note.content,
		bg = _options.noteBg,
		fg = _options.noteFg,
		shape = AwesomeWM.gears.shape.rounded_rect,
		widget = AwesomeWM.wibox.container.background,
	})

	return note
end

remindersComponent.reminders = AwesomeWM.wibox.widget({
	spacing = 10,
	widget = AwesomeWM.wibox.layout.fixed.vertical,
})

remindersComponent.scroller = AwesomeWM.wibox.widget({
	remindersComponent.reminders,
	widget = AwesomeWM.wibox.layout.flex.vertical,
})

remindersComponent.editButton = helper_sm.makeButton({
	widget = AwesomeWM.wibox.widget({
		markup = "<b>󰏫</b>",
		valign = "center",
		align = "center",
		font = AwesomeWM.beautiful.nerdFont .. " 30",
		widget = AwesomeWM.wibox.widget.textbox,
	}),

	onClick = function()
		AwesomeWM.awful.spawn(
			AwesomeWM.values.terminal .. " -e " .. AwesomeWM.values.editor .. " " .. remindersComponent.reminderFile
		)
		AwesomeWM.widgets.pages.dashboard.toggle()
	end,

	overrides = {
		padding = 0,
		buttonShape = AwesomeWM.gears.shape.rounded_rect,
		inactiveButtonBg = AwesomeWM.beautiful.white,
		inactiveButtonBorderColor = AwesomeWM.beautiful.white,
		buttonBorderWidth = 0,
		inactiveButtonFg = AwesomeWM.beautiful.black,
	},
})

remindersComponent.layout = AwesomeWM.wibox.widget({
	remindersComponent.editButton.main,
	remindersComponent.scroller,
	spacing = 10,
	widget = AwesomeWM.wibox.layout.fixed.vertical,
})

remindersComponent.main = AwesomeWM.wibox.widget({
	remindersComponent.layout,
	margins = 10,
	widget = AwesomeWM.wibox.container.margin,
})

remindersComponent.refresh = function()
	local isHeading = true
	local heading = ""
	local counter = 1
	remindersComponent.list = {}

	if AwesomeWM.gears.filesystem.file_readable(remindersComponent.reminderFile) == false then
		AwesomeWM.notify.critical("Reminder file not readable")
		return
	end

	for line in io.lines(remindersComponent.reminderFile) do
		if line == "" then
			isHeading = true
			goto continue
		end
		if isHeading then
			remindersComponent.list[counter] = { heading = line, body = "" }
			heading = line
			isHeading = false
			counter = counter + 1
		else
			if remindersComponent.list[counter - 1].body == "" then
				remindersComponent.list[counter - 1].body = line
			else
				remindersComponent.list[counter - 1].body = remindersComponent.list[counter - 1].body .. "\n" .. line
			end
		end
		::continue::
	end

	remindersComponent.reminders:reset()

	for index, note in pairs(remindersComponent.list) do
		remindersComponent.reminders:add(remindersComponent.makeReminder(note.heading, note.body, {}).main)
	end
end

return remindersComponent
