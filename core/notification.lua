-- Library
--------------------------------------------
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi
local naughty = require('naughty')
local util = require("utilities")
local wibox = require('wibox')

-- Configuration
----------------------------------------------
naughty.config.defaults.ontop   = true
naughty.config.defaults.title   = 'SYSTEM NOTIFICATION'
naughty.config.defaults.screen  = awful.screen.focused()

-- Timeouts
naughty.config.defaults.timeout         = 30
naughty.config.presets.low.timeout      = 8
naughty.config.presets.critical.timeout = 0

-- Error handling
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- Notification Template Setup
---------------------------------------------------------------------
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
                    resize_strategy = 'center',
                    widget = naughty.widget.icon,
                },
                -- right
                {
                    {
                        align = "left",
                        widget = naughty.widget.title,
                    },
                    {
                        align = "left",
                        widget = naughty.widget.message,
                    },
                    fill_space = true,
                    layout = wibox.layout.fixed.vertical,
                },
                fill_space = true,
                layout = wibox.layout.flex.horizontal,
            },
            strategy = "exact",
            width = beautiful.notification_max_width or dpi(500),
            height = beautiful.notification_max_height or dpi(100),
            widget = wibox.container.constraint
        }
    }

    -- Play sound
    --------------------------------------------------
    if not _G.dont_disturb then
        -- Depends: libcanberra
        awful.spawn('canberra-gtk-play -i message', false)
    end
end)
