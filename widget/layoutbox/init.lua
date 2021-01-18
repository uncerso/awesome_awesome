local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local clickable_container = require('widget.clickable-container')

local layout_box = function(s)
    local layoutbox = wibox.widget {
        {
            awful.widget.layoutbox(s),
            margins = beautiful.wibar_extra_item_margin,
            widget = wibox.container.margin
        },
        widget = clickable_container
    }
    layoutbox:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
                ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
                )
        )
    )
    return layoutbox
end

return layout_box