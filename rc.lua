
-- Load modules
-----------------------------------------------------------------------------------------------------------------------
local awful         =   require("awful")
local beautiful     =   require("beautiful")
local gears         =   require("gears")
local wibox         =   require("wibox")
local core          =   require("core")
local util          =   require("utilities")
local smartBorder   =   require("utilities.smart-border")
local widg          =   require("widgets")
                        require("awful.autofocus")


--------        Environmen
------------------------------------------------------------------------------------
local env           =   require("environment")
env:init()
--------        Layouts
------------------------------------------------------------------------------------
local layout        =   core.layouts
layout:init()

--------        keys
------------------------------------------------------------------------------------
local keys          =    core.keys

-- Taglist widget
--------------------------------------------------------------------------------
local taglist_buttons = awful.util.table.join(
	awful.button({         }, 1, function(t) t:view_only() end),
	awful.button({         }, 2, awful.tag.viewtoggle)
)

--------        Tasklis
------------------------------------------------------------------------------------
local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end))
-- Textclock
------------------------------------------------------------------------------------
local textclock = wibox.widget.textclock("%A %d :: %m (%B) :: %Y  %H:%M", 60)

-- sysmon
------------------------------------------------------------------------------------
local sysmon = {
   battery          = require("widgets.battery"),
   backlight        = require("widgets.backlight"),
   volume           = require("widgets.volume")
}

-- systray
-------------------------------------------------------------------------------------
local systray       = wibox.widget.systray()

-- systray
-------------------------------------------------------------------------------------
local profile       = require("widgets.profile")

-- separator
-------------------------------------------------------------------------------------
local separator     = util.separator.pad(1)

-- Screen setup
-----------------------------------------------------------------------------------------------------------------------
awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    env.set_wallpaper(s)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    -- Each screen has its own tag table.
    awful.tag(env.taglist, s, awful.layout.layouts[1])
    
    --taglist 
    s.mytaglist = awful.widget.taglist{
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style   = {
            shape = custom_shape
        }
    }
    
    -- tasklist
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style    = {
            shape  = custom_shape,
        },
        layout   = {
            spacing = 10,
            layout  = wibox.layout.flex.horizontal
        },
    }

    -- bottom wibar
    s.wibar_top    = awful.wibar({ position = "top", screen = s, height =  beautiful.wibar.top })
    s.wibar_top:setup
    {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(s.mylayoutbox,"layoutbox"),
            env.wrapper(s.mytaglist,"taglist")
        },
        {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(sysmon.backlight(),"battery"),
            env.wrapper(sysmon.battery(),"battery"),
            env.wrapper(sysmon.volume(),"volume")
        }
    }

    -- bottom wibar
    s.wibar_bottom = awful.wibar({ position = "bottom", screen = s, height =  beautiful.wibar.bottom })
    s.wibar_bottom:setup{
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(profile(),"profile")
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(s.mytasklist,"tasklist")
        },
        {
            layout = wibox.layout.align.horizontal,
            textclock,
            separator,
            env.wrapper(systray,"systray")
        }
    }

end)

-- shortened tasklist's name 
client.connect_signal("property::name", function(c)
    local client_name = c.name
    if  string.len(client_name) > 30  then
       c.name = string.sub(client_name,1,20)
    end
end)

client.connect_signal("request::titlebars", function(c) smartBorder.set(c, true) end)
client.connect_signal("property::size", smartBorder.set)

client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
      client.focus = c
    end
end)

client.connect_signal("focus", function(c)
    -- no border for maximized clients
    if c.maximized_horizontal == true and c.maximized_vertical == true then
      c.border_width = 0
    elseif #awful.client.visible(mouse.screen) > 1 then
      c.border_width = beautiful.border_width
      c.border_color = beautiful.border_focus
    else
      c.border_width = 0
    end
end)

client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)