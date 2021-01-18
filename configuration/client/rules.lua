local awful = require('awful')
local ruled = require('ruled')
local beautiful = require('beautiful')

-- Rules to apply to new clients.
ruled.client.connect_signal(
    'request::rules',
    function()
        -- All clients will match this rule.
        ruled.client.append_rule {
            id = 'global',
            rule = {},
            properties = {
                focus = awful.client.focus.filter,
                raise = true,
                floating = false,
                maximized = false,
                above = false,
                below = false,
                ontop = false,
                sticky = false,
                maximized_horizontal = false,
                maximized_vertical = false,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen
            }
        }

        ruled.client.append_rule {
            id = 'round_clients',
            rule_any = {
                type = {
                    'normal',
                    'dialog'
                }
            },
            except_any  = {
                name = {'Discord Updater'}
            },
            properties = {
                round_corners = true,
                shape = beautiful.client_shape_rounded,
                titlebars_enabled = false
            }
        }

        -- Terminal emulators
        ruled.client.append_rule {
            id = 'terminals',
            rule_any = {
                class = {
                    'URxvt',
                    'XTerm',
                    'UXTerm',
                    'kitty',
                    'K3rmit'
                }
            },
            properties = {
                -- tag = '1',
                -- switch_to_tags = true,
                size_hints_honor = false,
                titlebars_enabled = false
            }
        }

        ruled.client.append_rule {
            id = 'internet',
            rule = { class = 'firefox' },
            properties = {
                round_corners = true,
                shape = beautiful.client_shape_rectangle,
                screen = 1,
                tag = "3"
            }
        }

        ruled.client.append_rule {
            id = 'telegram',
            rule = { class = 'TelegramDesktop' },
            properties = {
                screen = 1,
                tag = "5"
            }
        }

        ruled.client.append_rule {
            id = 'teams',
            rule = { class = 'Microsoft Teams - Preview' },
            properties = {
                screen = 1,
                tag = "6"
            }
        }
        -- ruled.client.append_rule {
        --     id = 'helpers',
        --     rule = { skip_taskbar = true },
        --     properties = {
        --         floating = true,
        --         fullscreen = false,
        --     }
        -- }

        ruled.client.append_rule {
            id = 'vlc',
            rule = { class = 'vlc' },
            except = { name = 'vlc' },
            properties = {
                fullscreen = true,
            }
        }

        ruled.client.append_rule {
            id = 'calc',
            rule = { class = 'Gnome-calculator' },
            properties = {
                floating = true,
            }
        }

        ruled.client.append_rule {
            id = 'helpers',
            rule_any = { type = {'dialog', 'utility'} },
            properties = {
                floating = true,
            }
        }
    end
)

-- client.connect_signal(
--     'property::name',
--     function(c)
--         awesome.emit_signal('debug_msg', tostring(c.class) .. ' | ' .. c.name)
--     end
-- )

-- -- Normally we'd do this with a rule, but some program like spotify doesn't set its class or name
-- -- until after it starts up, so we need to catch that signal.
-- client.connect_signal(
-- 	'property::class',
-- 	function(c)
-- 		if c.class == 'Spotify' then
-- 			local window_mode = false

-- 			-- Check if fullscreen or window mode
-- 			if c.fullscreen then
-- 				window_mode = false
-- 				c.fullscreen = false
-- 			else
-- 				window_mode = true
-- 			end

-- 			-- Check if Spotify is already open
-- 			local app = function (c)
-- 				return ruled.client.match(c, {class = 'Spotify'})
-- 			end

-- 			local app_count = 0
-- 			for c in awful.client.iterate(app) do
-- 				app_count = app_count + 1
-- 			end

-- 			-- If Spotify is already open, don't open a new instance
-- 			if app_count > 1 then
-- 				c:kill()
-- 				-- Switch to previous instance
-- 				for c in awful.client.iterate(app) do
-- 					c:jump_to(false)
-- 				end
-- 			else
-- 				-- Move the instance to specified tag on this screen
-- 				local t = awful.tag.find_by_name(awful.screen.focused(), '5')
-- 				c:move_to_tag(t)
-- 				t:view_only()

-- 				-- Fullscreen mode if not window mode
-- 				if not window_mode then
-- 					c.fullscreen = true
-- 				else
-- 					c.floating = true
-- 					awful.placement.centered(c, {honor_workarea = true})
-- 				end
-- 			end
-- 		end
-- 	end
-- )
