local setmetatable 	= setmetatable
local unpack 		= unpack or table.unpack
local wibox     	= require("wibox")
local beautiful 	= require("beautiful")
local gears		 	= require("gears")
local util 			= require("utilities")


-----------------------------------------------------------------------------------------------------------------------
local volume = { mt = {} }

-----------------------------------------------------------------------------------------------------------------------
function volume.getValue()
    local stdout        = util.read.output("xbacklight -get")
    local brightness 	= string.match(stdout, '(%d+)')
	return tonumber(brightness)/100
end

-----------------------------------------------------------------------------------------------------------------------
function volume.new()
	--------------------------------------------------------------------------------
	local style =  { width   = 150, margin = { 5, 0, 5, 5 } }
	--------------------------------------------------------------------------------
	local text = util.background("BRIGHTNESS","roboto bold 10 ",beautiful.color.orange,"#000000")
	--------------------------------------------------------------------------------
	local layout = wibox.layout.fixed.horizontal()
    layout:add(text)
	--------------------------------------------------------------------------------
	local dash = util.progressbar.horizontal()

	local t = gears.timer({ timeout = 2 })
	t:connect_signal("timeout", function()
		dash:set_value(volume.getValue())
	end)
	t:start()

	layout:add(wibox.container.margin(dash, unpack(style.margin)))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "max", style.width)

	return widg
end
-----------------------------------------------------------------------------------------------------------------------
function volume.mt:__call(...)
	return volume.new(...)
end
return setmetatable(volume, volume.mt)