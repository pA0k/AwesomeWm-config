-- Library
--------------------------------------------------------
local awful         =   require("awful")
local beautiful     =   require("beautiful")
local keys          =   require("core.keys")

-- rules
--------------------------------------------------------
awful.rules.rules = {
    -- all clients
    {
      rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        maximized_horizontal = false,
        maximized_vertical = false,
        maximized = false,
        raise = true,
        keys = keys.clientkeys,
        buttons = keys.clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        size_hints_honor = false,
      }
    },
    {
			rule_any   = { type = { "normal" }},
			properties = { 
        titlebars_enabled = true,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen 
      }
		},
    { 
      rule_any = { 
        class = { "MPlayer","Mpv","Alacritty","Subl3"},
        role  = { "AlarmWindow", "pop-up" },
        type  = { "dialog" }
      },
      properties = 
      { 
        floating = true , 
        border_width = 0 , 
        placement = awful.placement.centered , 
        titlebars_enabled = false 
      } 
    },
    {
      rule = { instance = "Xephyr" },
      properties = { fullscreen = true }
    },
    -- Jetbrains splash screen fix
		{
			rule_any = { class = { "jetbrains-%w+", "java-lang-Thread" } },
			callback = function(jetbrains)
				if jetbrains.skip_taskbar then
                    jetbrains.floating = true
                end
			end
		},
    -- feh
    {
      rule_any = { class = {"feh","Lxappearance","Blueman-manager"} },
      properties = { 
        floating = true,
        placement = awful.placement.centered,
      },
    }
}
