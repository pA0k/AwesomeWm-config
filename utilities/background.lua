--------        LIBRARY
------------------------------------------------------------------------------------
local setmetatable  = setmetatable
local wibox         = require("wibox")
local util          = require("utilities")

local module        = {}

local function new(textbox,font_name,background,foreground)
   local wid = wibox.widget {
        {
            {
                text = "   "..textbox.."   ",
                font = font_name,
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.align.horizontal
        },
        bg = background,
        fg = foreground,
        shape = util.shape.rectangle.first_style,
        widget = wibox.container.background
    }
    return wid
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })