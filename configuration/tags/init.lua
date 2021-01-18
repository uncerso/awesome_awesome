local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local icons = require('theme.icons')
local apps = require('configuration.apps')
local make_kbdcfg = require('module.keyboard_layout')

local tags = {
    {
        type = 'terminal',
        icon = icons.terminal,
        gap = beautiful.useless_gap,
        layout = awful.layout.suit.tile
    },
    {
        type = 'terminal',
        icon = icons.terminal,
        gap = beautiful.useless_gap,
        layout = awful.layout.suit.tile
    },
    {
        type = 'internet',
        icon = icons.web_browser,
        gap = beautiful.useless_gap,
        layout = awful.layout.suit.max
    },
    {
        type = 'internet',
        icon = icons.web_browser,
        gap = beautiful.useless_gap,
        layout = awful.layout.suit.max
    },
    {
      type = 'social',
      icon = icons.social,
      gap = beautiful.useless_gap
    },
    {
        type = 'social',
        icon = icons.social,
        gap = beautiful.useless_gap
    },
    {
        type = 'any',
        icon = icons.development,
        gap = beautiful.useless_gap,
        layout = awful.layout.suit.fair
    },
    {
        type = 'any',
        icon = icons.development,
        gap = beautiful.useless_gap,
        layout = awful.layout.suit.corner.nw --awful.layout.suit.floating
    }
}

-- Set tags layout
tag.connect_signal(
    'request::default_layouts',
    function()
        awful.layout.append_default_layouts({
            awful.layout.suit.spiral.dwindle,
            awful.layout.suit.tile,
            -- awful.layout.suit.floating,
            awful.layout.suit.max
        })
    end
)

-- Create tags for each screen
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        local default_tag = 1
        for i, tag in pairs(tags) do
            awful.tag.add(
                i,
                {
                    icon = tag.icon,
                    icon_only = true,
                    layout = tag.layout or awful.layout.suit.spiral.dwindle,
                    gap_single_client = true,
                    gap = tag.gap,
                    screen = s,
                    kbdcfg = make_kbdcfg(),
                    use = function(t) t.kbdcfg:restore(); t:view_only() end,
                    -- default_app = tag.default_app,
                    selected = i == default_tag
                }
            )
        end
        s.tags[default_tag].kbdcfg:restore()
    end
)

local update_gap_and_shape = function(t)
    -- Get current tag layout
    local current_layout = awful.tag.getproperty(t, 'layout')
    -- If the current layout is awful.layout.suit.max
    if (current_layout == awful.layout.suit.max) then
        -- Set clients gap to 0 and shape to rectangle if maximized
        t.gap = 0
        for _, c in ipairs(t:clients()) do
            if not c.floating or not c.round_corners or c.maximized or c.fullscreen then
                c.shape = beautiful.client_shape_rectangle
            else
                c.shape = beautiful.client_shape_rounded
            end
        end
    else
        t.gap = beautiful.useless_gap
        for _, c in ipairs(t:clients()) do
            if not c.round_corners or c.maximized or c.fullscreen then
                c.shape = beautiful.client_shape_rectangle
            else
                c.shape = beautiful.client_shape_rounded
            end
        end
    end
end

-- Change tag's client's shape and gap on change
tag.connect_signal(
    'property::layout',
    function(t)
        update_gap_and_shape(t)
    end
)

-- Change tag's client's shape and gap on move to tag
tag.connect_signal(
    'tagged',
    function(t)
        update_gap_and_shape(t)
    end
)

-- -- Focus on urgent clients
-- awful.tag.attached_connect_signal(
--     s,
--     'property::selected',
--     function()
--         local urgent_clients = function (c)
--             return awful.rules.match(c, {urgent = true})
--         end
--         for c in awful.client.iterate(urgent_clients) do
--             if c.first_tag == mouse.screen.selected_tag then
--                 c:emit_signal('request::activate')
--                 c:raise()
--             end
--         end
--     end
-- )
