local awful = require('awful')
local icons = require('theme.icons')
local slider_maker = require('module.slider_maker')

local volume_osd_overlay, slider_osd, osd_value, current_icon = slider_maker('Volume', 'vol_osd_slider', icons.volume)

local update_vol = function()
    awful.spawn.easy_async_with_shell(
        [[amixer -D pulse sget Master | grep -E '\[[0-9]{1,3}%\] \[(on|off)\]' -o | head -n 1]],
        function(stdout)
            -- stdout sample:[25%] [on]
            sep = stdout:find(' ')
            value = tonumber(stdout:sub(2, sep-3))
            is_muted = stdout:sub(sep+2, stdout:len()-2) == 'off'
            awesome.emit_signal('module::volume_osd', value)
        end
    )
end

local vol_osd_slider = slider_osd.vol_osd_slider

vol_osd_slider:connect_signal(
    'property::value',
    function()
        local volume_level = vol_osd_slider:get_value()
        awful.spawn('amixer -q -D pulse sset Master ' .. volume_level .. '%', false)

        osd_value.text = volume_level .. '%'
        -- -- Update the volume slider if values here change
        -- awesome.emit_signal('widget::volume:update', volume_level)
        awesome.emit_signal('module::osd_manager::show', awful.screen.focused().volume_osd_overlay)
    end
)

-- The emit will come from the volume-slider
awesome.connect_signal(
    'module::volume_osd',
    function(volume)
        vol_osd_slider:set_value(volume)
        awesome.emit_signal('module::osd_manager::show', awful.screen.focused().volume_osd_overlay)
    end
)

screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        s.volume_osd_overlay = volume_osd_overlay(s)

        -- Reset timer on mouse hover
        s.volume_osd_overlay:connect_signal(
            'mouse::enter', 
            function()
                awesome.emit_signal('module::osd_manager::show', s.volume_osd_overlay)
            end
        )
    end
)

awesome.connect_signal(
    'module::volume_osd:show', 
    function()
        update_vol()
    end
)
