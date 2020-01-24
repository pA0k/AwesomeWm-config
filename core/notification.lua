-- Library
--------------------------------------------
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')
local naughty = require('naughty')
local util = require("utilities")
local wibox = require('wibox')


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
                        naughty.widget.title,
                        naughty.widget.message,
                    },
                    spacing = 2,
                    layout = wibox.layout.fixed.vertical,
                },
                fill_space = true,
                spacing = 4,
                layout = wibox.layout.flex.horizontal,
            },
            strategy = "max",
            width = beautiful.notification_max_width or dpi(500),
            height = beautiful.notification_max_height or dpi(100),
            widget = wibox.container.constraint,
        }
    }

    -- Play sound
    --------------------------------------------------
    if not _G.dont_disturb then
        -- Add Sound fx to notif
        -- Depends: libcanberra
        awful.spawn('canberra-gtk-play -i screen-capture', false)
    end
end)
