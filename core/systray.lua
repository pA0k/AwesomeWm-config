--------        LIBRARY
------------------------------------------------------------------------------------
local awful       = require("awful")
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
    local tray 	= wibox.widget.systray()
	--------------------------------------------------------------------------------
	layout:add(wibox.container.margin(progressbar, unpack(style.margin)))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "max", style.width)
	return widg
end

-----------------------------------------------------------------------------------------------------------------------
function systray.mt:__call(...)
	return systray.new(...)
end
return setmetatable(systray, systray.mt)

