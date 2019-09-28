local awful       = require("awful")
local beautiful   = require("beautiful")
local wibox       = require("wibox")
local gears       = require("gears")
local util        = require("utilities")

local exit_screen     = { }

-- functions
function exit_screen.quit()
    awesome.quit()
end

function exit_screen.hide()
  exit_screen.widg.visible = false
end

function exit_screen.show()
    exit_screen.widg.visible = true
    -- run keygrabber
    awful.keygrabber.run(function(mod, key, event)
      if event == "release" then return end
      -- key
      if  key == 'Escape' or key == 'q' or key == 'e' then 
        exit_screen.hide()
        awful.keygrabber.stop()
      elseif key == 'y'         then exit_screen.quit()
        exit_screen.quit()
        awful.keygrabber.stop()
      end
  end)

end

local height_exitscreen      = screen[mouse.screen].geometry.height/2.8
local width_exitscreen       = screen[mouse.screen].geometry.width/2.5
local positionx              = (screen[mouse.screen].geometry.width - width_exitscreen)/2
local positiony              = (screen[mouse.screen].geometry.height - height_exitscreen)/2

-- Create the widget
exit_screen.widg = wibox({
    x             = positionx,
    y             =  positiony,
    border_width  = 15,
    border_color  = beautiful.color.bg,
    ontop         = true,
    visible       = hide,
    type          = "dock",
    height        = height_exitscreen,
    width         = width_exitscreen,
    bg            = beautiful.color.black,
    shape         = util.shape.rectangle.second_style
})

  -- BTN 1
  local btn_1 = util.button("YES - EXIT","Roboto 11 Bold")
  btn_1:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_screen.quit()
                 end)
  ))

  -- BTN 2
  local btn_2 = util.button("CANCEL","Roboto 11 Bold")
  btn_2:buttons(gears.table.join(
                 awful.button({ }, 1, function ()
                  exit_screen.hide()
                 end)
  ))


local alert_icon      = wibox.widget.imagebox(beautiful.icons.alert)
local warning_text    = util.text("WARNING SYSTEM","Blender Pro bold  40")
local msg_widget      = util.text("DO YOU WANT EXIT FROM THE CURRENT SESSION  ?","Industry-Bold  22")

exit_screen.widg:setup {
    {
      {
        {
          alert_icon,
          warning_text ,
          layout = wibox.layout.align.horizontal,
        },
        top =20,
        left=35,
        bottom = 0,
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
      top = 10,
      right = 10,
      left = 10,
      bottom = 10,
      widget = wibox.container.margin
    },
    {
      {
        btn_1,
        btn_2,
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      top = 20,
      right = 10,
      left = 35,
      bottom = 20,
      widget = wibox.container.margin
    },
    layout = wibox.layout.flex.vertical
}

return exit_screen
