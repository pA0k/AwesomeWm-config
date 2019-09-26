local wibox       = require("wibox")
local beautiful   = require("beautiful")
local util        = require("utilities")

local module      = {}

local function new(textbox,font_name)
    local button = wibox.widget {
        {
            {
                text = "   "..textbox.."   ",
                font = font_name,
                widget = wibox.widget.textbox
            },
            layout = wibox.layout.align.horizontal
        },
        bg = beautiful.color.bg,
        shape = util.shape.rectangle.second_style,
        widget = wibox.container.background
    }

    -- change color
    button:connect_signal("mouse::enter", function()
        button.bg  = beautiful.color.green
        button.fg  = beautiful.color.black
        local w = mouse.current_wibox
        old_cursor, old_wibox = w.cursor, w
        w.cursor = "hand1"
      end)
      
    button:connect_signal("mouse::leave", function()
        button.bg  = beautiful.color.bg
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    return button
end


return setmetatable(module, { __call = function(_, ...) return new(...) end })