local awful 		= require("awful")
local gears 		= require("gears")
local setmetatable 	= setmetatable
local unpack 		= unpack or table.unpack
local beautiful 	= require("beautiful")
local util 			= require("utilities")
local wibox 		= require("wibox")

-----------------------------------------------------------------------------------------------------------------------
local volume = { mt = {} }

-------------------------------------------------------------------------------------------------------------
function volume.getValue()
    local stdout = util.read.output("cat /sys/class/power_supply/BAT0/capacity")
    return tonumber(stdout / 100)
end

-----------------------------------------------------------------------------------------------------------------------
function volume.new()

    -- Initialize vars
    --------------------------------------------------------------------------------
    local style = { width = 150, margin = { 5, 0, 5, 5 } }
    --------------------------------------------------------------------------------
    local text = util.background("BATTERY", "roboto bold 10 ", beautiful.color.orange, "#000000")
    --------------------------------------------------------------------------------
    local layout = wibox.layout.fixed.horizontal()
    layout:add(text)
    --------------------------------------------------------------------------------
    local dash = util.progressbar.horizontal()

    local t = gears.timer({ timeout = 2 })
    t:connect_signal("timeout", function()
        local volume_value = volume.getValue()
        dash:set_value(volume_value)
    end)
    t:start()
    --------------------------------------------------------------------------------
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