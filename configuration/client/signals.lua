local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local ruled = require('ruled')

local update_client = function(c)
	-- Set client's shape based on its tag's layout and status (floating, maximized, etc.)
	local current_layout = awful.tag.getproperty(c.first_tag, 'layout')
	if current_layout == awful.layout.suit.max and (not c.floating) then
		c.shape = beautiful.client_shape_rectangle
	elseif c.maximized or c.fullscreen then
		c.shape = beautiful.client_shape_rectangle
	elseif (not c.round_corners) then
		c.shape = beautiful.client_shape_rectangle
	else
		c.shape = beautiful.client_shape_rounded
	end
end

client.connect_signal(
    'focus',
    function(c)
        c.border_color = beautiful.border_focus
    end
)

client.connect_signal(
    'unfocus',
    function(c)
        c.border_color = beautiful.border_normal
    end
)

-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
    'property::fullscreen',
    function(c)
        if c.fullscreen then
            c.shape = beautiful.client_shape_rectangle
        else
            update_client(c)
        end
    end
)

-- Manipulate client shape on maximized
client.connect_signal(
    'property::maximized',
    function(c)
        if c.maximized then
            c.shape = beautiful.client_shape_rectangle
        else
            update_client(c)
        end
    end
)

-- Manipulate client shape on floating
client.connect_signal(
    'property::floating',
    function(c)
        local current_layout = awful.tag.getproperty(c.first_tag, 'layout')
        if c.floating and not c.maximized then
            c.shape = beautiful.client_shape_rounded
        else
            if current_layout == awful.layout.suit.max then
                c.shape = beautiful.client_shape_rectangle
            end
        end
    end
)
