local unpack    = unpack or table.unpack
local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")


local switcher = { }

-----------------------------------------------------------------------------------------------------------------------
function switcher:init()

	self.client_list    = 0

	--------------------------------------------------------------------------------
	self.wibox = wibox({
		x 			 = 0,
		y			 = 100,
		ontop        = true,
		bg           = beautiful.color.bg,
		border_width = 5,
        border_color = beautiful.color.green,
        width        = 500,
        height       = 500
	})

end

-----------------------------------------------------------------------------------------------------------------------
function switcher:show()
	self:init()
	self.wibox.visible = true
end

function switcher:hide()
	self.wibox.visible = false
end

return switcher