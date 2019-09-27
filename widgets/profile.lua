local setmetatable 	= setmetatable
local unpack 		= unpack or table.unpack
local awful         = require("awful")
local wibox     	= require("wibox")
local beautiful 	= require("beautiful")
local gears		 	= require("gears")
local util 			= require("utilities")


-----------------------------------------------------------------------------------------------------------------------
local profile = { mt = {} }

-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		width   = 150,
		dmargin = { 2, 0, 5, 5 },
	}
	return style
end


function profile.getUserName()
	local stdout        = util.read.output("whoami")
	return tostring(string.upper(stdout))
end

-----------------------------------------------------------------------------------------------------------------------
function profile.new()
	-- Initialize vars
	--------------------------------------------------------------------------------
	local style = default_style()
	--------------------------------------------------------------------------------
	local name = profile.getUserName()
	local text = util.background("PARANOID73","roboto Bold 10",beautiful.color.orange,beautiful.color.black)
	--------------------------------------------------------------------------------
	local layout = wibox.layout.fixed.horizontal()
    layout:add(text)
	--------------------------------------------------------------------------------
	local dash = wibox.widget.imagebox("/home/paranoid73/Pictures/logo/React-icon.svg")

	layout:add(wibox.container.margin(dash, unpack(style.dmargin)))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "exact", style.width)

	return widg
end

-----------------------------------------------------------------------------------------------------------------------
function profile.mt:__call(...)
	return profile.new(...)
end
return setmetatable(profile, profile.mt)