local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local slider_maker = function (title, slider_id, icon_image)
    local osd_header = wibox.widget {
        text = title,
        font = 'Inter Bold 12',
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local osd_value = wibox.widget {
        text = '',
        font = 'Inter Bold 12',
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local slider_osd = wibox.widget {
        nil,
        {
            id = slider_id,
            bar_shape = gears.shape.rounded_rect,
            bar_height = dpi(2),
            bar_color = '#ffffff20',
            bar_active_color = '#f2f2f2EE',
            handle_color = '#ffffff',
            handle_shape = gears.shape.circle,
            handle_width = dpi(15),
            handle_border_color = '#00000012',
            handle_border_width = dpi(1),
            maximum = 100,
            widget = wibox.widget.slider
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
    }

    local icon = wibox.widget {
        {
            image = icon_image,
            resize = true,
            widget = wibox.widget.imagebox
        },
        top = dpi(12),
        bottom = dpi(12),
        widget = wibox.container.margin
    }

    local slider_osd_widget = wibox.widget {
        icon,
        slider_osd,
        spacing = dpi(24),
        layout = wibox.layout.fixed.horizontal
    }

    local osd_height = dpi(100)
    local osd_width = dpi(300)

    local overlay_maker = function (s)
        local overlay = awful.popup {
            widget = {
                    -- Removing this block will cause an error...
            },
            ontop = true,
            visible = false,
            type = 'notification',
            screen = s,
            height = osd_height,
            width = osd_width,
            maximum_height = osd_height,
            maximum_width = osd_width,
            offset = dpi(5),
            bg = beautiful.transparent,
            preferred_anchors = 'middle',
            preferred_positions = {'left', 'right', 'top', 'bottom'},
            shape = gears.shape.rounded_rect,
        }

        overlay : setup {
            {
                {
                    {
                        layout = wibox.layout.align.horizontal,
                        expand = 'none',
                        forced_height = dpi(48),
                        osd_header,
                        nil,
                        osd_value
                    },
                    slider_osd_widget,
                    layout = wibox.layout.fixed.vertical
                },
                left = dpi(24),
                right = dpi(24),
                widget = wibox.container.margin
            },
            bg = beautiful.background,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background(),
            border_color = beautiful.accent,
            border_width = dpi(1),
        }

        return overlay
    end

    return overlay_maker, slider_osd, osd_value, icon.widget
end

return slider_maker