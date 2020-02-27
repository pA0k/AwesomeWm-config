-------- LIBRARY
-------------------------------------------------
local setmetatable = setmetatable
local wibox = require("wibox")

local module = {}

local function new(textbox, font_name, background, foreground)
    local wid = wibox.widget {
        {
            {
                widget = wibox.widget.textclock
            },
            layout = wibox.layout.align.horizontal
        },
        bg = background,
        fg = foreground,
        widget = wibox.container.background
    }
    return wid
end

return setmetatable(module, { __call = function(_, ...) return new(...) end })