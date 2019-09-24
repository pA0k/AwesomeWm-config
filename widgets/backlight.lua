-----------------------------------------------------------------------------------------------------------------------
--                                                  Backlight                                               --
-----------------------------------------------------------------------------------------------------------------------
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local watch         = require("awful.widget.watch")
local util          = require("utilities")


-- Initialize tables and variables for module
-----------------------------------------------------------------------------------------------------------------------
local BL_VALUE      = 'bash -c "xbacklight -get"'
local BL_WIDGET     = util.bar()
BL_WIDGET:fit(100,100)

watch(BL_VALUE,1,function(widget, stdout, _, _, _)
    local brightness = string.match(stdout, '(%d+)')
    local level      = tonumber(brightness) / 100
    widget:set_value(level)
end,BL_WIDGET)

return BL_WIDGET