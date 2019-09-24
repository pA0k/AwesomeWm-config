-----------------------------------------------------------------------------------------------------------------------
--                                                Layouts config                                                     --
-----------------------------------------------------------------------------------------------------------------------
local awful         =   require("awful")

local layout        =   {}

-- Build  table
-----------------------------------------------------------------------------------------------------------------------
function layout:init()
	-- layouts list
	local layset = {
        awful.layout.suit.max,
        awful.layout.suit.tile,
		awful.layout.suit.floating,
        awful.layout.suit.fair,
        awful.layout.suit.spiral,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier
	}
	awful.layout.layouts = layset
end


-- End
-----------------------------------------------------------------------------------------------------------------------
return layout