local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local utils = require('utils')
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.clickable-container')
local config = require('configuration.config')
local military_mode = config.widget.clock.military_mode or false

local create_clock = function(s)

    local clock_format = nil
    if not military_mode then
        clock_format = '<span font="' .. beautiful.font_bold .. '">%I:%M %p</span>'
    else
        clock_format = '<span font="' .. beautiful.font_bold .. '">%H:%M</span>'
    end

    local clock_widget = wibox.widget.textclock(
        clock_format,
        1
    )

    s.clock_widget = wibox.widget {
        {
            clock_widget,
            margins = beautiful.wibar_extra_item_margin,
            widget = wibox.container.margin,
    
        },
        widget = clickable_container
    }

    s.clock_tooltip = awful.tooltip
    {
        objects = {s.clock_widget},
        mode = 'outside',
        delay_show = 0.5,
        preferred_positions = {'right', 'left', 'top', 'bottom'},
        preferred_alignments = {'middle', 'front', 'back'},
        margin_leftright = dpi(8),
        margin_topbottom = dpi(8),
        timer_function = function()
            local ordinal = nil

            local day = os.date('%d')
            local month = os.date('%B')

            local first_digit = string.sub(day, 0, 1) 
            local last_digit = string.sub(day, -1) 

            if first_digit == '0' then
                day = last_digit
            end

            if last_digit == '1' and day ~= '11' then
                ordinal = 'st'
            elseif last_digit == '2' and day ~= '12' then
                ordinal = 'nd'
            elseif last_digit == '3' and day ~= '13' then
                ordinal = 'rd'
            else
                ordinal = 'th'
            end

            local date_str = 'Today is the ' ..
            '<b>' .. day .. ordinal .. 
            ' of ' .. month .. '</b>.\n' ..
            'And it\'s fucking ' .. os.date('%A')

            return date_str
        end,
    }

    utils.fix_tooltip_shape(s.clock_tooltip)

    s.clock_widget:connect_signal(
        'button::press',
        function(self, lx, ly, button)
            -- Hide the tooltip when you press the clock widget
            if s.clock_tooltip.visible and button == 1 then
                s.clock_tooltip.visible = false
            end
        end
    )
    
    s.month_calendar      = awful.widget.calendar_popup.month({
        start_sunday      = true,
        spacing           = dpi(5),
        font              = beautiful.font,
        long_weekdays     = true,
        margin            = dpi(5),
        screen            = s,
        style_month       = {
            border_width  = 0,
            bg_color      = beautiful.background,
            padding       = dpi(20),
            shape         = beautiful.tooltip_shape,
        },
        style_header      = { 
            border_width    = 0, 
            bg_color        = beautiful.transparent
        },
        style_weekday     = { 
            border_width    = 0, 
            bg_color        = beautiful.transparent
        },
        style_normal      = { 
            border_width    = 0, 
            bg_color        = beautiful.transparent
        },
        style_focus       = { 
            border_width    = dpi(0), 
            bg_color        = beautiful.accent, 
            shape           = function(cr, width, height)
                gears.shape.partially_rounded_rect(
                    cr, width, height, true, true, true, true, dpi(4)
                )
            end,
        },
    })

    s.month_calendar:set_border_width(beautiful.tooltip_border_width)
    s.month_calendar:set_border_color(beautiful.accent)
    s.month_calendar:set_shape(beautiful.tooltip_shape)

    s.month_calendar:attach(
        s.clock_widget, 
        'br', 
        { 
            on_pressed = true,
            on_hover = false 
        }
    )

    return s.clock_widget
end

return create_clock
