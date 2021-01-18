local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.clickable-container')
local icons = require('theme.icons')

--- Common method to create buttons.
-- @tab buttons
-- @param object
-- @return table
local function create_buttons(buttons, object)
	if buttons then
		local btns = {}
		for _, b in ipairs(buttons) do
			-- Create a proxy button object: it will receive the real
			-- press and release events, and will propagate them to the
			-- button object the user provided, but with the object as
			-- argument.
			local btn = awful.button {
				modifiers = b.modifiers,
				button = b.button,
				on_press = function()
					b:emit_signal('press', object)
				end,
				on_release = function()
					b:emit_signal('release', object)
				end
			}
			btns[#btns + 1] = btn
		end
		return btns
	end
end

local function list_update(w, buttons, label, data, objects)
	-- update the widgets, creating them if needed
	w:reset()
	for i, o in ipairs(objects) do
		local cache = data[o]
		
		local bgb
		if cache then
			bgb = cache.bgb
		else
			bgb = wibox.container.background({
				forced_width = dpi(20),
			})

			bgb:set_shape(gears.shape.rounded_rect)
			bgb.shape_border_width = dpi(1)
			bgb.shape_border_color = beautiful.background
			bgb:buttons(create_buttons(buttons, o))

			data[o] = {
				bgb = bgb,
			}
		end

		local _, bg = label(o)

		bgb:set_bg(bg)

		local wgc = wibox.widget {
			bgb,
			margins = dpi(4),
			widget = wibox.container.margin
		}

		w:add(wgc)
	end
end

local tag_list = function(s)
	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.table.join(
			awful.button(
				{},
				1,
				function(t)
					t:use()
				end
			),
			awful.button(
				{modkey},
				1,
				function(t)
					if _G.client.focus then
						_G.client.focus:move_to_tag(t)
						t:use()
					end
				end
			),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button(
				{modkey},
				3,
				function(t)
					if _G.client.focus then
						_G.client.focus:toggle_tag(t)
					end
				end
			)
		),
		update_function = list_update,
		layout = wibox.widget {
			spacing = dpi(-3),
			homogeneous     = true,
			vertical_expand = true,
			layout = wibox.layout.grid.horizontal(2)
		}
	}
	)
end
return tag_list
