local wibox 		= require('wibox')
local awful 		= require('awful')
local gears 		= require("gears")
local naughty 		= require("naughty")
local beautiful		= require("beautiful")
local util 			= require("utilities")

local mouse 		= mouse
local screen 		= screen
local table 		= table
local keygrabber 	= keygrabber
local client 		= client
local string 		= string
local tostring 		= tostring
local tonumber 		= tonumber
local debug 		= debug
local pairs 		= pairs
local unpack 		= unpack or table.unpack



local _M = {}


-- Create a wibox to contain all the client-widgets
_M.preview_wbox = wibox({ width = screen[mouse.screen].geometry.width/3 })
_M.preview_wbox.border_width 	= 5
_M.preview_wbox.ontop 			= true
_M.preview_wbox.visible 		= false



function _M.init()
	-- Apply settings
	_M.preview_wbox:set_bg("#252e25")
	_M.preview_wbox.border_color = "#384d30"

	-- Make the wibox the right size, based on the number of clients
	local n = 10
	local W = screen[mouse.screen].geometry.width -- + 2 * _M.preview_wbox.border_width
	local w = W / n -- widget width
	local h = w * 0.75  -- widget height
	local textboxHeight = w * 0.125

	local x = screen[mouse.screen].geometry.x - _M.preview_wbox.border_width
	local y = screen[mouse.screen].geometry.y + (screen[mouse.screen].geometry.height - h - textboxHeight) / 2
	_M.preview_wbox:geometry({x = x, y = y, width = 100, height = 100})

	-- create a list that holds the clients to preview, from left to right
	local client_name = wibox.widget.textbox("firefox")
	--layout
	local preview_layout = wibox.layout.fixed.vertical()
	for i = 1, 10 do
		preview_layout:add(client_name)
	end
	_M.preview_wbox:set_widget(preview_layout)
end


-- This starts the timer for updating and it shows the preview UI.
function _M.showPreview()
	_M.init()
	_M.preview_wbox.visible = true
end


return _M
