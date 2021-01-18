local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = beautiful.xresources.apply_dpi

local build_widget = function(widget, margin)
    margin = margin or beautiful.wibar_extra_margin
    return wibox.widget {
    {
        widget,
        border_width = beautiful.wibar_extra_border_width,
        -- border_color = beautiful.accent,
        border_color = beautiful.groups_title_bg,
        bg = beautiful.transparent,
        -- shape = gears.shape.rounded_rect,
        shape = gears.shape.rounded_bar,
        -- shape = function(cr, w, h)
        --     gears.shape.rounded_rect(cr, w, h, dpi(12))
        -- end,
        widget = wibox.container.background
    },
    top = margin,
    bottom = margin,
    widget = wibox.container.margin
    }
end

local make_keyboard_layout = function()
    kl = awful.widget.keyboardlayout()
    kl:connect_signal('button::press', function ()
        local t = awful.screen.focused().selected_tag
        t.kbdcfg:switch()
    end)
    return kl
end

local make_cpu_widget = function()
    return require("awesome-wm-widgets.cpu-widget.cpu-widget")({
        width = dpi(70),
        step_width = dpi(2),
        step_spacing = dpi(0),
        enable_kill_button = true,
    })
end

local keyboardlayout = build_widget(make_keyboard_layout())

local battery = build_widget(require('widget.battery')())
local network = build_widget(require('widget.network')())
local cpu_widget = build_widget(make_cpu_widget())
local ram_widget = require('awesome-wm-widgets.ram-widget.ram-widget')()
-- local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")()
-- local volumearc_widget = require("awesome-wm-widgets.volumearc-widget.volumearc")()
-- local wifi = require('net_widgets').wireless()
-- local eth = require('net_widgets').indicator({
--     interfaces  = {"eth0", "another_interface", "and_another_one"},
--     timeout     = 5
-- })

local bottom_panel =  function(s)
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    local clock   = build_widget(require('widget.clock')(s))
    local  layout_box = build_widget(require('widget.layoutbox')(s), dpi(0))
-- local task_list         = build_widget(require('widget.task-list')(s))
    local tag_list          = require('widget.tag-list')(s)
-- s.bluetooth               = build_widget(require('widget.bluetooth')())

    -- Create a taglist widget
    s.tag_list = build_widget(
        awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = { awful.button({ }, 1, function(t) t:use() end) }
        })

    -- Create a tasklist widget
    s.task_list = build_widget(
        awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = {
                awful.button({ }, 1, function (c)
                    c:activate { context = "tasklist", action = "toggle_minimization" }
                end),
                awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end)
            }
        })

    s.tray = build_widget(wibox.widget.systray(), beautiful.wibar_extra_item_margin)

    -- Create the wibox
    s.panel = awful.wibar({ position = "top", screen = selected_tag})

    -- Add widgets to the wibox
    s.panel.widget = {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            -- s.tag_list,
            tag_list,
            -- s.mypromptbox,
        },
        s.task_list, -- Middle widget
        -- task_list,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            cpu_widget,
            ram_widget,
            -- eth,
            -- wifi,
            keyboardlayout,
            s.tray,
            network,
            battery,
            clock,
            layout_box,
        },
    }
end

return bottom_panel
