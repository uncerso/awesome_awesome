local awful = require('awful')
local wibox = require('wibox')

-- Keyboard map indicator and changer
local make_kbdcfg = function()
    kbdcfg = {}
    kbdcfg.current = 0  -- default layout

    kbdcfg.restore = function (k)
        awesome.xkb_set_layout_group(k.current)
    end

    kbdcfg.switch = function (k)
        -- just update internal index, because keyboard layout has already changed by setxkbmap or awful.widget.keyboardlayout
        k.current = awesome.xkb_get_layout_group()
    end

    return kbdcfg
end

return make_kbdcfg