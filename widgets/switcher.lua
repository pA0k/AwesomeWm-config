local unpack    = unpack or table.unpack
local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")


-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local switcher = { }

-- this function returns the list of clients to be shown.
local getClients = function ()
	local clients = {}

	-- Get focus history for current tag
	local s = mouse.screen;
	local idx = 0
	local c = awful.client.focus.history.get(s, idx)

	while c do
		table.insert(clients, c)

		idx = idx + 1
		c = awful.client.focus.history.get(s, idx)
	end

	-- Minimized clients will not appear in the focus history
	-- Find them by cycling through all clients, and adding them to the list
	-- if not already there.
	-- This will preserve the history AND enable you to focus on minimized clients

	local t = s.selected_tag
	local all = client.get(s)

	for i = 1, #all do
		local c = all[i]
		local ctags = c:tags();

		-- check if the client is on the current tag
		local isCurrentTag = false
		for j = 1, #ctags do
			if t == ctags[j] then
				isCurrentTag = true
				break
			end
		end

		if isCurrentTag then
			-- check if client is already in the history
			-- if not, add it
			local addToTable = true
			for k = 1, #clients do
				if clients[k] == c then
					addToTable = false
					break
				end
			end


			if addToTable then
				table.insert(clients, c)
			end
		end
	end

	return clients
end

-----------------------------------------------------------------------------------------------------------------------
function switcher:init()

    getClients()
	--------------------------------------------------------------------------------
	self.client_list    = 0 

	--------------------------------------------------------------------------------
    local prompt_width  = 100
    local prompt_height = 100


	--------------------------------------------------------------------------------
	self.wibox = wibox({
		ontop        = true,
		bg           = beautiful.color.bg,
		border_width = 5,
        border_color = beautiful.color.orange,
        width        = prompt_width,
        height       = prompt_height 
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
