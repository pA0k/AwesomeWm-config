local awful       = require("awful")
local beautiful   = require("beautiful")
local wibox       = require("wibox")
local gears       = require("gears")
local util        = require("utilities")


local exit_screen     = { }

function exit_screen.quit()
    awesome.quit()
end

function exit_screen.hide()
  exit_screen.widg.visible = false
end

function exit_screen.show()
  exit_screen.widg.visible = true
end

local height_exitscreen      = screen[mouse.screen].geometry.height/4
local width_exitscreen       = screen[mouse.screen].geometry.width/4


  -- Create the widget
exit_screen.widg = wibox({
    x             = (screen[mouse.screen].geometry.width - width_exitscreen)/2 ,
    y             = (screen[mouse.screen].geometry.height - height_exitscreen)/2 ,
    border_width  = 10,
    border_color  = beautiful.color.bg,
    ontop         = true,
    visible       = hide,
    type          = "dock",
    height        = height_exitscreen,
    width         = width_exitscreen,
    bg            = beautiful.color.black
})

  -- BTN 1
  local btn_1 = util.button("YES - EXIT","Roboto 11")
  btn_1:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_screen.exit()
                 end)
  ))

  -- BTN 2
  local btn_2 = util.button("CANCEL","Roboto 11")
  btn_2:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_screen.hide()
                 end)
  ))


local alert_icon      = wibox.widget.imagebox(beautiful.icons.alert)
local warning_text    = util.text("WARNING SYSTEM","Roboto 10")
local msg_widget      = util.text("DO YOU WANT EXIT FROM THE CURRENT SESSION  ?","Roboto 10")

exit_screen.widg:setup {
    {
      {
        {
          alert_icon,
          warning_text ,
          layout = wibox.layout.align.horizontal,
        },
        widget = wibox.container.margin
        },
        fg = beautiful.color.white,
        widget = wibox.container.background
    },
    {
      {
        msg_widget,
        layout = wibox.layout.align.horizontal
      },
      widget = wibox.container.margin
    },
    {
      {
        btn_1,
        btn_2,
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      widget = wibox.container.margin
    },
    layout = wibox.layout.flex.vertical
}

return exit_screen
