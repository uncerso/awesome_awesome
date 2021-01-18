local awful = require("awful")
local icons = require('theme.icons')
local slider_maker = require('module.slider_maker')

local brightness_osd_overlay, slider_osd, osd_value = slider_maker('Brightness', 'bri_osd_slider', icons.brightness)

local update_bri = function()
    awful.spawn.easy_async_with_shell(
        [[brightnessctl -m i | grep -E '[0-9]{1,3}%' -o | tr -d '%\n']],
        function(stdout)
            value = tonumber(stdout)
            awesome.emit_signal('module::brightness_osd', value)
        end
    )
end

local bri_osd_slider = slider_osd.bri_osd_slider

bri_osd_slider:connect_signal(
    'property::value',
    function()
        local brightness_level = bri_osd_slider:get_value()
        awful.spawn('brightnessctl -q s ' .. brightness_level .. '%', false)

        -- Update textbox widget text
        osd_value.text = brightness_level .. '%'

        -- -- Update the brightness slider if values here change
        -- awesome.emit_signal('widget::brightness:update', brightness_level)

        awesome.emit_signal('module::osd_manager::show', awful.screen.focused().brightness_osd_overlay)
    end
)

-- The emit will come from brightness slider
awesome.connect_signal(
    'module::brightness_osd',
    function(brightness)
        bri_osd_slider:set_value(brightness)
        awesome.emit_signal('module::osd_manager::show', awful.screen.focused().brightness_osd_overlay)
    end
)

screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        s.brightness_osd_overlay = brightness_osd_overlay(s)

        -- Reset timer on mouse hover
        s.brightness_osd_overlay:connect_signal(
            'mouse::enter', 
            function()
                awesome.emit_signal('module::osd_manager::show', s.brightness_osd_overlay)
            end
        )
    end
)

awesome.connect_signal(
    'module::brightness_osd:show', 
    function()
        update_bri()
    end
)
