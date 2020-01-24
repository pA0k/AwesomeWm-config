local awful 		= require('awful')
local beautiful 	= require('beautiful')
local dpi 			= require('beautiful').xresources.apply_dpi
local gears 		= require('gears')
local naughty 		= require('naughty')
local util        	= require("utilities")
local wibox 		= require('wibox')


-- ===================================================================
-- Variable Definitions
-- ===================================================================


-- Defaults
naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 10
naughty.config.defaults.title = 'System Notification'

-- Apply theme variables
naughty.config.padding = 8
naughty.config.spacing = 8
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = 'top_right'

-- Timeouts
naughty.config.presets.low.timeout = 3
naughty.config.presets.critical.timeout = 0

naughty.config.presets.normal = {
	font         = beautiful.title_font,
	fg           = beautiful.fg_normal,
	bg           = beautiful.bg_normal,
	position     = 'top_right'
}

naughty.config.presets.low = {
	font         = beautiful.title_font,
	fg           = beautiful.fg_normal,
	bg           = beautiful.bg_normal,
	position     = 'top_right'
}

naughty.config.presets.critical = {
	font         = 'SF Display Bold 10',
	fg           = '#ffffff',
	bg           = '#ff0000',
	position     = 'top_right',
	timeout      = 0
}

naughty.config.presets.ok 	= naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical


-- ===================================================================
-- Error Handling
-- ===================================================================


if awesome.startup_errors then
	naughty.notify(
	{
		preset = naughty.config.presets.critical,
		title = 'Oops, there were errors during startup!',
		text = awesome.startup_errors
	}
	)
end

do
	local in_error = false
	awesome.connect_signal(
		'debug::error',
		function(err)
			if in_error then
				return
			end
			in_error = true

			naughty.notify(
			{
				preset = naughty.config.presets.critical,
				title = 'Oops, an error happened!',
				text = tostring(err)
			}
			)
			in_error = false
		end
		)
end


-- ===================================================================
-- Notification Template Setup
-- ===================================================================

naughty.connect_signal("request::display", function(n)
	naughty.layout.box {
		notification = n,
		type = "splash",
		shape = util.shape.rectangle.second_style,
		widget_template = {
			{
				--left
				{
					--icon
					{
						resize_strategy = 'center',
						widget = naughty.widget.icon,
					},
					margins = dpi(10),
					widget  = wibox.container.margin,
				},
				-- right
				{
					naughty.widget.title,
					naughty.widget.message,
					spacing = 4,
					layout  = wibox.layout.fixed.vertical,
				},
				fill_space = true,
				spacing    = 4,
				layout     = wibox.layout.flex.horizontal,
			},
			strategy 	= "max",
			width    	= beautiful.notification_max_width or dpi(500),
			height    	= beautiful.notification_max_height or dpi(100),
			bg 			= beautiful.color.bg, 
			widget   	= wibox.container.constraint,
		}

	}

	if not _G.dont_disturb then
		-- Add Sound fx to notif
		-- Depends: libcanberra
		awful.spawn('canberra-gtk-play -i message', false)
	end

end)
