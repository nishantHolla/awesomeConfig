
local mediaComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper
local values_sm = AwesomeWM.widgets.pages.values
local thumbnailLocation = AwesomeWM.values.mediaFile
local lastUrl = ''

mediaComponent.albumImage = AwesomeWM.wibox.widget({
	image = thumbnailLocation,
	resize = true,
	widget = AwesomeWM.wibox.widget.imagebox
})

mediaComponent.albumArtist = AwesomeWM.wibox.widget({
	text = 'artist',
	valign = 'center',
	align = 'left',
	font = AwesomeWM.beautiful.pagesFont .. ' 20',
	widget = AwesomeWM.wibox.widget.textbox
})

mediaComponent.albumTitle = AwesomeWM.wibox.widget({
	text = 'title',
	valign = 'center',
	align = 'left',
	font = AwesomeWM.beautiful.pagesFont .. ' 15',
	widget = AwesomeWM.wibox.widget.textbox,
})


mediaComponent.previous = AwesomeWM.wibox.widget({
	text = '󰒮',
	font = AwesomeWM.beautiful.nerdFont .. ' 40',
	valign = 'center',
	align = 'center',
	widget = AwesomeWM.wibox.widget.textbox
})

mediaComponent.playPause = AwesomeWM.wibox.widget({
	text = '󰐎',
	font = AwesomeWM.beautiful.nerdFont .. ' 40',
	valign = 'center',
	align = 'center',
	widget = AwesomeWM.wibox.widget.textbox
})

mediaComponent.next = AwesomeWM.wibox.widget({
	text = '󰒭',
	font = AwesomeWM.beautiful.nerdFont .. ' 40',
	valign = 'center',
	align = 'center',
	widget = AwesomeWM.wibox.widget.textbox
})

mediaComponent.top = AwesomeWM.wibox.widget({
	{
		mediaComponent.albumImage,
		valign = 'center',
		align = 'center',
		widget = AwesomeWM.wibox.container.place
	},
	{
		mediaComponent.albumArtist,
		mediaComponent.albumTitle,
		widget = AwesomeWM.wibox.layout.flex.vertical,
	},
	spacing = 10,
	widget = AwesomeWM.wibox.layout.ratio.horizontal
})

mediaComponent.top:set_ratio(2, 0.7)

mediaComponent.buttonOverrides = {
	padding = 10,
}

mediaComponent.bottom = AwesomeWM.wibox.widget({
	helper_sm.makeButton({
		widget = mediaComponent.previous,
		onClick = function()
			AwesomeWM.functions.player.previous()
			mediaComponent.albumImage.update()
			mediaComponent.albumTitle.update()
			mediaComponent.albumArtist.update()
		end,
		overrides = mediaComponent.buttonOverrides,
	}).main,
	helper_sm.makeButton({
		widget = mediaComponent.playPause,
		onClick = function()
			AwesomeWM.functions.player.toggle()
			mediaComponent.playPause.update()
		end,
		overrides = mediaComponent.buttonOverrides,
	}).main,
	helper_sm.makeButton({
		widget = mediaComponent.next,
		onClick = function()
			AwesomeWM.functions.player.next()
			mediaComponent.albumImage.update()
			mediaComponent.albumTitle.update()
			mediaComponent.albumArtist.update()
		end,
		overrides = mediaComponent.buttonOverrides,
	}).main,
	spacing = 50,
	widget = AwesomeWM.wibox.layout.fixed.horizontal
})

mediaComponent.layout = AwesomeWM.wibox.widget({
	mediaComponent.top,
	{
		mediaComponent.bottom,
		align = 'center',
		widget = AwesomeWM.wibox.container.place
	},
	spacing = 10,
	widget = AwesomeWM.wibox.layout.ratio.vertical
})


mediaComponent.main = AwesomeWM.wibox.widget({
	mediaComponent.layout,
	margins = 20,
	widget = AwesomeWM.wibox.container.margin
})

mediaComponent.albumArtist.update = function()
	local script = AwesomeWM.values.getScript('player')
	AwesomeWM.awful.spawn.easy_async(script .. ' getArtist', function(_stdout, _stderr, _exitReason, _exitCode)
		mediaComponent.albumArtist.text = _stdout
	end)
end

mediaComponent.playPause.update = function()
	AwesomeWM.awful.spawn.easy_async('playerctl status', function(_stdout, _stderr, _exitReason, _exitCode)
		if _stdout == "Paused\n" then
			mediaComponent.playPause.text = "󰐊"
		elseif _stdout == "Playing\n" then
			mediaComponent.playPause.text = "󰏤"
		end
	end)
end

mediaComponent.albumImage.update = function()
	local script = AwesomeWM.values.getScript('player')
	AwesomeWM.awful.spawn.easy_async(script .. ' getImage', function(_stdout, _stderr, _exitReason, _exitCode)
		if lastUrl == _stdout then
			return
		else
			lastUrl = _stdout
		end

		if string.starts(_stdout, "https") then
			AwesomeWM.awful.spawn('wget ' .. _stdout .. ' -O ' .. thumbnailLocation)

		elseif string.starts(_stdout, "file") then
			local path = string.sub(_stdout, 8)
			AwesomeWM.awful.spawn('cp -f ' .. path .. ' ' .. thumbnailLocation)

		elseif _stderr == "No players found\n" or _stdout == "\n" then
			AwesomeWM.awful.spawn('rm ' .. thumbnailLocation)
		end

		mediaComponent.albumImage.image = AwesomeWM.gears.surface.load_uncached(thumbnailLocation)
	end)

	mediaComponent.albumImage.image = AwesomeWM.gears.surface.load_uncached(thumbnailLocation)
end

mediaComponent.albumTitle.update = function()
	local script = AwesomeWM.values.getScript('player')
	AwesomeWM.awful.spawn.easy_async(script .. ' getTitle', function(_stdout, _stderr, _exitReason, _exitCode)
		mediaComponent.albumTitle.text = _stdout
	end)
end

mediaComponent.refresh = function()

	mediaComponent.albumImage.update()
	mediaComponent.albumArtist.update()
	mediaComponent.playPause.update()
	mediaComponent.albumTitle.update()

end

mediaComponent.timer = AwesomeWM.gears.timer({
	timeout = 1,
	callback = mediaComponent.refresh
})

return mediaComponent
