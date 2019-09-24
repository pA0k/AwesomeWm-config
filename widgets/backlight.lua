local setmetatable 	= setmetatable
local unpack 		= unpack or table.unpack
local awful         = require("awful")
local wibox     	= require("wibox")
local beautiful 	= require("beautiful")
local gears		 	= require("gears")
local read_cmd 		= require("utilities.read")
local backg 		= require("utilities.background")
local progressbar   = require("utilities.progressbar")


-----------------------------------------------------------------------------------------------------------------------
local volume = { mt = {} }

-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		width   = 150,
		dmargin = { 5, 0, 5, 5 },
	}
	return style
end


function volume.getValue()
	local CMD_VL      	= "xbacklight -get"
    local stdout        = read_cmd.output(CMD_VL)
    local brightness = string.match(stdout, '(%d+)')
	return tonumber(brightness) / 100
end

-----------------------------------------------------------------------------------------------------------------------
function volume.new()
	
	-- Initialize vars
	--------------------------------------------------------------------------------
	local style = default_style()
	--------------------------------------------------------------------------------
	local text = backg("BRIGHTNESS","roboto bold 10 ",beautiful.color.orange,"#000000")
	--------------------------------------------------------------------------------
	local layout = wibox.layout.fixed.horizontal()
    layout:add(text)
	--------------------------------------------------------------------------------
	local dash = progressbar.horizontal()

	local t = gears.timer({ timeout = 2 })
	t:connect_signal("timeout", function()
		dash:set_value(volume.getValue())
	end)
	t:start()


	layout:add(wibox.container.margin(dash, unpack(style.dmargin)))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "max", style.width)

	return widg
end

-----------------------------------------------------------------------------------------------------------------------
function volume.mt:__call(...)
	return volume.new(...)
end
return setmetatable(volume, volume.mt)