local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("configuration.apps").default

local modkey = require("configuration.keys.mod").mod_key
local altkey = require("configuration.keys.mod").alt_key
local PgUp = "Prior"
local PgDn = "Next"

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)
-- }}}

awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "\\", function()
        os.execute('pactl set-source-port alsa_input.pci-0000_00_1f.3.analog-stereo analog-input-headset-mic; pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones', false)
    end,
        {description = "poweroff", group = "hotkeys"}
    )
})

awful.keyboard.append_global_keybindings({
    awful.key({"Control", "Shift", modkey, altkey}, "Return", function()
        os.execute('poweroff')
    end,
        {description = "poweroff", group = "hotkeys"}
    )
})

awful.keyboard.append_global_keybindings({
    awful.key({}, "ISO_Next_Group", function()
        local t = awful.screen.focused().selected_tag
        t.kbdcfg:switch()
    end)
})

-- {{{ Key bindings

-- Display brightness
awful.keyboard.append_global_keybindings({
    awful.key({}, "XF86MonBrightnessUp", function()
            awful.spawn('brightnessctl s +5%', false)
            -- awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = "increase brightness up by 5%", group = "hotkeys"}
    ),
    awful.key({}, "XF86MonBrightnessDown",  function()
            awful.spawn('brightnessctl s 5%-', false)
            -- awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = "decrease brightness up by 5%", group = "hotkeys"}
    ),
    awful.key({"Control"}, "XF86MonBrightnessUp", function()
            awful.spawn('brightnessctl s +1%', false)
            -- awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = "increase brightness up by 1%", group = "hotkeys"}
    ),
    awful.key({"Control"}, "XF86MonBrightnessDown",  function()
            awful.spawn('brightnessctl s 1%-', false)
            -- awesome.emit_signal('widget::brightness')
            awesome.emit_signal('module::brightness_osd:show', true)
        end,
        {description = "decrease brightness up by 1%", group = "hotkeys"}
    ),
})

awful.keyboard.append_global_keybindings({
    awful.key({}, "Print", function() awful.spawn(apps.screenshot, false) end,
        {description = 'Take a screenshot of your active monitor and copy it to clipboard', group = 'screenshots (clipboard)'}),
    awful.key({modkey}, "Print", function() awful.spawn(apps.region_screenshot, false) end,
        {description = 'Mark an area and screenshot it to your clipboard', group = 'screenshots (clipboard)'}),
})

-- ALSA volume control
awful.keyboard.append_global_keybindings({
    awful.key({}, 'XF86AudioRaiseVolume', function()
            awful.spawn('amixer -D pulse sset Master 5%+', false)
            -- awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show')
        end,
        {description = 'increase volume up by 5%', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioLowerVolume', function()
            awful.spawn('amixer -D pulse sset Master 5%-', false)
            -- awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show')
        end,
        {description = 'decrease volume up by 5%', group = 'hotkeys'}
    ),
    awful.key({"Control"}, 'XF86AudioRaiseVolume', function()
        awful.spawn('amixer -D pulse sset Master 1%+', false)
        -- awesome.emit_signal('widget::volume')
        awesome.emit_signal('module::volume_osd:show')
    end,
    {description = 'increase volume up by 1%', group = 'hotkeys'}
    ),
    awful.key({"Control"}, 'XF86AudioLowerVolume', function()
            awful.spawn('amixer -D pulse sset Master 1%-', false)
            -- awesome.emit_signal('widget::volume')
            awesome.emit_signal('module::volume_osd:show')
        end,
        {description = 'decrease volume up by 1%', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioMute', function()
            awful.spawn('amixer -D pulse set Master 1+ toggle', false)
            -- awesome.emit_signal('module::volume_osd:show')
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    )
})

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
            {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "s", function () mymainmenu:show() end,
            {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, altkey }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, altkey }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey },            "`",     function () awful.spawn(apps.rofi) end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, PgUp,   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, PgDn,  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ altkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey, "Shift"    }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "Down",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Right", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey,           }, "Left",  function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey, "Control" }, "Right", function () awful.tag.incmwfact( 0.01)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "Left",  function () awful.tag.incmwfact(-0.01)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})

local get_tag_index = function(index)
    local tag_map = {
        ['1'] = 0,
        ['q'] = 1,
        ['2'] = 2,
        ['w'] = 3,
        ['3'] = 4,
        ['e'] = 5,
        ['4'] = 6,
        ['r'] = 7,
    }
    index = tag_map[index]
    if not index then
        return index
    end
    local screen = awful.screen.focused()
    if screen.tags[index + 1] == screen.selected_tag then
        index = index ~ 1
    end
    return index + 1
end

local bind = function(func, arg)
    return function() func(arg) end
end

local view_tag = function (index)
    index = get_tag_index(index)
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
        tag:use()
    end
end

local toggle_tag = function (index)
    index = get_tag_index(index)
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
        awful.tag.viewtoggle(tag)
    end
end

local move_focused_client_to_tag = function (index)
    index = get_tag_index(index)
    if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end
end

local toggle_focused_client_on_tag = function (index)
    index = get_tag_index(index)
    if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
            client.focus:toggle_tag(tag)
        end
    end
end

awful.keyboard.append_global_keybindings({
    awful.key ({ modkey }, '1', bind(view_tag, '1'), { description = "view the first line tag", group = "tag"}),
    awful.key ({ modkey }, '2', bind(view_tag, '2'), { description = "view the first line tag", group = "tag"}),
    awful.key ({ modkey }, '3', bind(view_tag, '3'), { description = "view the first line tag", group = "tag"}),
    awful.key ({ modkey }, '4', bind(view_tag, '4'), { description = "view the first line tag", group = "tag"}),
    awful.key ({ modkey }, 'q', bind(view_tag, 'q'), { description = "view the second line tag", group = "tag"}),
    awful.key ({ modkey }, 'w', bind(view_tag, 'w'), { description = "view the second line tag", group = "tag"}),
    awful.key ({ modkey }, 'e', bind(view_tag, 'e'), { description = "view the second line tag", group = "tag"}),
    awful.key ({ modkey }, 'r', bind(view_tag, 'r'), { description = "view the second line tag", group = "tag"}),

    awful.key ({ modkey, "Shift" }, '1', bind(toggle_tag, '1'), { description = "toggle the first line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, '2', bind(toggle_tag, '2'), { description = "toggle the first line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, '3', bind(toggle_tag, '3'), { description = "toggle the first line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, '4', bind(toggle_tag, '4'), { description = "toggle the first line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, 'q', bind(toggle_tag, 'q'), { description = "toggle the second line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, 'w', bind(toggle_tag, 'w'), { description = "toggle the second line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, 'e', bind(toggle_tag, 'e'), { description = "toggle the second line tag", group = "tag"}),
    awful.key ({ modkey, "Shift" }, 'r', bind(toggle_tag, 'r'), { description = "toggle the second line tag", group = "tag"}),

    awful.key ({ modkey, "Control" }, '1', bind(move_focused_client_to_tag, '1'), { description = "move focused client to the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, '2', bind(move_focused_client_to_tag, '2'), { description = "move focused client to the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, '3', bind(move_focused_client_to_tag, '3'), { description = "move focused client to the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, '4', bind(move_focused_client_to_tag, '4'), { description = "move focused client to the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, 'q', bind(move_focused_client_to_tag, 'q'), { description = "move focused client to the second line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, 'w', bind(move_focused_client_to_tag, 'w'), { description = "move focused client to the second line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, 'e', bind(move_focused_client_to_tag, 'e'), { description = "move focused client to the second line tag", group = "tag"}),
    awful.key ({ modkey, "Control" }, 'r', bind(move_focused_client_to_tag, 'r'), { description = "move focused client to the second line tag", group = "tag"}),

    awful.key ({ modkey, "Control", "Shift" }, '1', bind(toggle_focused_client_on_tag, '1'), { description = "toggle focused client on the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, '2', bind(toggle_focused_client_on_tag, '2'), { description = "toggle focused client on the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, '3', bind(toggle_focused_client_on_tag, '3'), { description = "toggle focused client on the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, '4', bind(toggle_focused_client_on_tag, '4'), { description = "toggle focused client on the first line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, 'q', bind(toggle_focused_client_on_tag, 'q'), { description = "toggle focused client on the second line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, 'w', bind(toggle_focused_client_on_tag, 'w'), { description = "toggle focused client on the second line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, 'e', bind(toggle_focused_client_on_tag, 'e'), { description = "toggle focused client on the second line tag", group = "tag"}),
    awful.key ({ modkey, "Control", "Shift" }, 'r', bind(toggle_focused_client_on_tag, 'r'), { description = "toggle focused client on the second line tag", group = "tag"}),

    -- awful.key {
    --     modifiers   = { modkey },
    --     keygroup    = "numpad",
    --     description = "select layout directly",
    --     group       = "layout",
    --     on_press    = function (index)
    --         index = get_tag_index(index)
    --         local t = awful.screen.focused().selected_tag
    --         if t then
    --             t.layout = t.layouts[index] or t.layout
    --         end
    --     end,
    -- }
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ altkey            }, "q",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "Down",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "Up",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- }}}