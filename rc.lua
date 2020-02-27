pcall(require, "luarocks.loader")
-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
-- Custom library
local core = require("core")
local util = require("utilities")
local widg = require("widgets")


-------- environment
------------------------------------------------------------------------------------
local env = require("environment")
env:init()
require("core.rules")
require("core.notification")

-- Layouts
local layout = core.layouts
layout:init()

-- keys
local keys = core.keys

--  Textclock
local textclock = widg.textclock()


-- sysmon
local sysmon = {
    battery = widg.battery,
    backlight = widg.backlight,
    volume = widg.volume,
}

-- systray
local systray = wibox.widget.systray()

-- systray
local profile = widg.profile

-- separator
local separator = util.separator.pad(1)

-- Screen setup
awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    env.set_wallpaper(s)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Each screen has its own tag table.
    awful.tag(env.taglist, s, awful.layout.layouts[1])

    --taglist 
    s.mytaglist = core.taglist(s)
    --- - tasklist
    s.mytasklist = core.tasklist(s)

    -- top wibar
    ----------------------------------------------------------------------------------------
    s.wibar_top = awful.wibar({ position = "top", screen = s, height = beautiful.wibar.top })
    s.wibar_top:setup
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.align.horizontal,
                env.wrapper(s.mylayoutbox, "layoutbox"),
                env.wrapper(s.mytaglist, "taglist")
            },
            {
                layout = wibox.layout.align.horizontal,
                expand = "outside",
            },
            {
                layout = wibox.layout.align.horizontal,
                env.wrapper(sysmon.backlight(), "battery"),
                env.wrapper(sysmon.battery(), "battery"),
                env.wrapper(sysmon.volume(), "volume")
            }
        }

    -- bottom wibar
    --------------------------------------------------------------------------------------------------
    s.wibar_bottom = awful.wibar({ position = "bottom", screen = s, height = beautiful.wibar.bottom })
    s.wibar_bottom:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(profile(), "profile")
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(s.mytasklist, "tasklist")
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(textclock, "profile"),
            separator,
            env.wrapper(systray, "systray")
        }
    }
end)

-- shortened tasklist's name 
client.connect_signal("property::name", function(c)
    local client_name = c.name
    if string.len(client_name) > 35 then
        c.name = string.sub(client_name, 1, 35)
    end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)



