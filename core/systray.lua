--------        LIBRARY
------------------------------------------------------------------------------------
local awful       = require("awful")
local beautiful   = require("beautiful")
local gears       = require("gears")
local wibox       = require("wibox")
local progressbar = require("utilities.progressbar.dot")

----------------------------------------------------------------------------------------------------------------------
local systray = { mt = {} }

-------------------------------------------------------------------------------------------------------------
function systray.new()
	-- Initialize vars
	--------------------------------------------------------------------------------
    local style = { width   = 150, margin = { 5, 0, 5, 5 } }
    --------------------------------------------------------------------------------
    local layout = wibox.layout.fixed.horizontal()
    self.tray = wibox.widget.systray()
    -------------------------------------------------------------------------------
    layout:set_middle(self.tray)
	--------------------------------------------------------------------------------
	layout:add(wibox.container.margin(dash, unpack(style.margin)))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "max", style.width)
	return widg
end

-----------------------------------------------------------------------------------------------------------------------
function systray.mt:__call(...)
	return systray.new(...)
end
return setmetatable(systray, systray.mt)

