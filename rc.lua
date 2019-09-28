pcall(require, "luarocks.loader")

-- Standard awesome library
local awful         =   require("awful")
local gears         =   require("gears")
                        require("awful.autofocus")
-- Widget and layout library
local wibox         =   require("wibox")
local beautiful     =   require("beautiful")
-- Custom library
local core          =   require("core")
local util          =   require("utilities")
local widg          =   require("widgets")


--------        Environmen
------------------------------------------------------------------------------------
local env           =   require("environment")
env:init()
require("core.rules")

-- Layouts
local layout        =   core.layouts
layout:init()

-- keys
local keys          =    core.keys

-- Taglist widget 
local taglist_buttons = awful.util.table.join(
	awful.button({         }, 1, function(t) t:view_only() end),
	awful.button({         }, 2, awful.tag.viewtoggle)
)

--  Tasklis
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
--  Textclock
local textclock = wibox.widget.textclock("%A %d :: %m (%B) :: %Y  %H:%M", 60)


-- sysmon
local sysmon = {
   battery          = widg.battery,
   backlight        = widg.backlight,
   volume           = widg.volume
}

-- systray
local systray       = wibox.widget.systray()

-- systray
local profile       = widg.profile

-- separator
local separator     = util.separator.pad(1)

-- Screen setup
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
        buttons = taglist_buttons
    }
    ---- tasklist
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout   = {
            spacing = 10,
            layout  = wibox.layout.flex.horizontal
        },
    }
    -------------------------
    -- bottom wibar       ---
    -------------------------
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
    if  string.len(client_name) > 35  then
       c.name = string.sub(client_name,1,35)
    end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)