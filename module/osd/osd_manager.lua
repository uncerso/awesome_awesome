local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local osd_show_timer = gears.timer {
    timeout = 2,
    callback  = function()
        awesome.emit_signal('module::osd_manager::hide')
    end
}

local  last_osd = nil

local place = function(osd)
    local osd_margin = dpi(10)
    awful.placement.bottom_right(
        osd,
        {
            margins = { 
                left = 0,
                right = osd_margin,
                top = 0,
                bottom = osd_margin,
            },
            honor_workarea = true
        }
    )
end

local reset = function(osd)
    if osd ~= last_osd then
        awesome.emit_signal('module::osd_manager::hide')
        last_osd = osd
        last_osd.visible = true
        place(last_osd)
    end
end

awesome.connect_signal(
    'module::osd_manager::show',
    function(osd)
        reset(osd)
        if osd_show_timer.started then
            osd_show_timer:again()
        else
            osd_show_timer:start()
        end
    end
)

awesome.connect_signal(
    'module::osd_manager::hide',
    function()
        if last_osd then
            last_osd.visible = false
            last_osd = nil
        end
    end
)