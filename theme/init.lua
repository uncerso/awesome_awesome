local gears = require('gears')
local beautiful = require('beautiful')
local filesystem = require('gears.filesystem')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local titlebar_theme = 'lines'
local titlebar_icon_path = theme_dir .. '/icons/titlebar/' .. titlebar_theme .. '/'
local tip = titlebar_icon_path
local dpi = beautiful.xresources.apply_dpi
local gtk_variable = beautiful.gtk.get_theme_variables

local theme = {}

theme.dir = theme_dir
theme.icons = theme_dir .. '/icons/'

theme.font = 'Inter Regular 10'
theme.font_bold = 'Inter Bold 10'

-- Wallpaper path
theme.wallpaper = theme_dir .. '/wallpapers/6.png'

-- Colorscheme
theme.system_black_dark = '#3D4C5F'
theme.system_black_light = '#56687E'

theme.system_red_dark = '#ec0101'
theme.system_red_light = '#F48FB1'

theme.system_green_dark = '#06a284'
theme.system_green_light = '#A1EFD3'

theme.system_yellow_dark = '#ffd86e'
theme.system_yellow_light = '#F1FA8C'

theme.system_blue_dark = '#2777ff' 
theme.system_blue_light = '#92B6F4'

theme.system_magenta_dark = '#985EFF'
theme.system_magenta_light = '#BD99FF'

theme.system_cyan_dark = '#24D1E7'
theme.system_cyan_light = '#87DFEB'

theme.system_white_dark = '#E5E5E5'
theme.system_white_light = '#F8F8F2'

-- Accent color
theme.accent = theme.system_green_dark
theme.alert = theme.system_red_dark .. '99'

-- Background color
theme.background = '#000000' .. '40'
theme.dark_background = theme.background:sub(1,7) .. 'bb'

-- Transparent
theme.transparent = '#00000000'

-- Foreground
theme.fg_normal = '#ffffffde'
theme.fg_focus = '#e4e4e4'
theme.fg_urgent = theme.fg_normal

-- Background
theme.bg_normal = theme.background
theme.bg_focus = theme.dark_background
theme.bg_urgent = theme.alert

-- System tray
theme.bg_systray = '#20324a'
theme.systray_icon_spacing = dpi(16)

-- Titlebar
theme.titlebar_size = dpi(34)
theme.titlebar_bg_focus = gtk_variable().bg_color:sub(1,7) .. '50'
theme.titlebar_bg_normal = gtk_variable().base_color:sub(1,7) .. '50'
theme.titlebar_fg_focus = gtk_variable().fg_color
theme.titlebar_fg_normal = gtk_variable().fg_color

-- Close Button
theme.titlebar_close_button_normal = tip .. 'close_normal.svg'
theme.titlebar_close_button_focus  = tip .. 'close_focus.svg'

-- Minimize Button
theme.titlebar_minimize_button_normal = tip .. 'minimize_normal.svg'
theme.titlebar_minimize_button_focus  = tip .. 'minimize_focus.svg'

-- Ontop Button
theme.titlebar_ontop_button_normal_inactive = tip .. 'ontop_normal_inactive.svg'
theme.titlebar_ontop_button_focus_inactive  = tip .. 'ontop_focus_inactive.svg'
theme.titlebar_ontop_button_normal_active = tip .. 'ontop_normal_active.svg'
theme.titlebar_ontop_button_focus_active  = tip .. 'ontop_focus_active.svg'

-- Sticky Button
theme.titlebar_sticky_button_normal_inactive = tip .. 'sticky_normal_inactive.svg'
theme.titlebar_sticky_button_focus_inactive  = tip .. 'sticky_focus_inactive.svg'
theme.titlebar_sticky_button_normal_active = tip .. 'sticky_normal_active.svg'
theme.titlebar_sticky_button_focus_active  = tip .. 'sticky_focus_active.svg'

-- Floating Button
theme.titlebar_floating_button_normal_inactive = tip .. 'floating_normal_inactive.svg'
theme.titlebar_floating_button_focus_inactive  = tip .. 'floating_focus_inactive.svg'
theme.titlebar_floating_button_normal_active = tip .. 'floating_normal_active.svg'
theme.titlebar_floating_button_focus_active  = tip .. 'floating_focus_active.svg'

-- Maximized Button
theme.titlebar_maximized_button_normal_inactive = tip .. 'maximized_normal_inactive.svg'
theme.titlebar_maximized_button_focus_inactive  = tip .. 'maximized_focus_inactive.svg'
theme.titlebar_maximized_button_normal_active = tip .. 'maximized_normal_active.svg'
theme.titlebar_maximized_button_focus_active  = tip .. 'maximized_focus_active.svg'

-- Hovered Close Button
theme.titlebar_close_button_normal_hover = tip .. 'close_normal_hover.svg'
theme.titlebar_close_button_focus_hover  = tip .. 'close_focus_hover.svg'

-- Hovered Minimize Buttin
theme.titlebar_minimize_button_normal_hover = tip .. 'minimize_normal_hover.svg'
theme.titlebar_minimize_button_focus_hover  = tip .. 'minimize_focus_hover.svg'

-- Hovered Ontop Button
theme.titlebar_ontop_button_normal_inactive_hover = tip .. 'ontop_normal_inactive_hover.svg'
theme.titlebar_ontop_button_focus_inactive_hover  = tip .. 'ontop_focus_inactive_hover.svg'
theme.titlebar_ontop_button_normal_active_hover = tip .. 'ontop_normal_active_hover.svg'
theme.titlebar_ontop_button_focus_active_hover  = tip .. 'ontop_focus_active_hover.svg'

-- Hovered Sticky Button
theme.titlebar_sticky_button_normal_inactive_hover = tip .. 'sticky_normal_inactive_hover.svg'
theme.titlebar_sticky_button_focus_inactive_hover  = tip .. 'sticky_focus_inactive_hover.svg'
theme.titlebar_sticky_button_normal_active_hover = tip .. 'sticky_normal_active_hover.svg'
theme.titlebar_sticky_button_focus_active_hover  = tip .. 'sticky_focus_active_hover.svg'

-- Hovered Floating Button
theme.titlebar_floating_button_normal_inactive_hover = tip .. 'floating_normal_inactive_hover.svg'
theme.titlebar_floating_button_focus_inactive_hover  = tip .. 'floating_focus_inactive_hover.svg'
theme.titlebar_floating_button_normal_active_hover = tip .. 'floating_normal_active_hover.svg'
theme.titlebar_floating_button_focus_active_hover  = tip .. 'floating_focus_active_hover.svg'

-- Hovered Maximized Button
theme.titlebar_maximized_button_normal_inactive_hover = tip .. 'maximized_normal_inactive_hover.svg'
theme.titlebar_maximized_button_focus_inactive_hover  = tip .. 'maximized_focus_inactive_hover.svg'
theme.titlebar_maximized_button_normal_active_hover = tip .. 'maximized_normal_active_hover.svg'
theme.titlebar_maximized_button_focus_active_hover  = tip .. 'maximized_focus_active_hover.svg'

-- UI Groups
theme.groups_title_bg = '#ffffff' .. '15'
theme.groups_bg = '#ffffff' .. '10'
theme.groups_radius = dpi(9)

-- UI events
theme.leave_event = theme.transparent
theme.enter_event = theme.background
theme.press_event = theme.dark_background
theme.release_event = theme.enter_event

-- Client Decorations

-- Borders
theme.border_focus = theme.accent
theme.border_normal = theme.transparent
theme.border_marked = '#CC9393'
theme.border_width = dpi(0)
theme.border_radius = dpi(9)

-- Decorations
theme.useless_gap = dpi(4)
theme.client_shape_rectangle = gears.shape.rectangle
theme.client_shape_rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, dpi(9))
end

-- Menu
theme.menu_font = 'Inter Regular 11'
theme.menu_submenu = '➤' -- ➤

theme.menu_height = dpi(34)
theme.menu_width = dpi(200)
theme.menu_border_width = dpi(10)
theme.menu_bg_focus = theme.accent .. 'CC'

theme.menu_bg_normal =  theme.background:sub(1,7) .. '33'
theme.menu_fg_normal = '#ffffff'
theme.menu_fg_focus = '#ffffff'
theme.menu_border_color = theme.background:sub(1,7) .. '5C'

-- Tooltips

theme.tooltip_bg = theme.dark_background
theme.tooltip_border_color = theme.accent
theme.tooltip_border_width = dpi(1)
theme.tooltip_gaps = dpi(5)
theme.tooltip_shape = gears.shape.rounded_rect

-- Separators
theme.separator_color = '#f2f2f244'

-- Layoutbox icons
theme.layout_max = theme.icons .. 'layouts/max.svg'
theme.layout_tile = theme.icons .. 'layouts/tile.svg'
theme.layout_dwindle = theme.icons .. 'layouts/dwindle.svg'
theme.layout_floating = theme.icons .. 'layouts/floating.svg'

-- Taglist
theme.taglist_bg_empty = theme.background .. '99'
theme.taglist_bg_occupied =  '#ffffff' .. '1A'
theme.taglist_bg_urgent = theme.system_red_dark .. '99'
theme.taglist_bg_focus = theme.accent


-- -- Taglist
-- theme.taglist_bg_empty = theme.background .. '99'
-- theme.taglist_bg_occupied =  '#ffffff' .. '1A'
-- theme.taglist_bg_urgent = theme.system_red_dark .. '99'
-- theme.taglist_bg_focus = theme.dark_background
-- theme.taglist_spacing = dpi(0)

-- -- Tasklist
-- theme.tasklist_font = 'Inter Regular 10'
-- theme.tasklist_bg_normal = theme.background .. '99'
-- theme.tasklist_bg_focus = theme.background
-- theme.tasklist_bg_urgent = '#E91E63' .. '99'
-- theme.tasklist_fg_focus = '#DDDDDD'
-- theme.tasklist_fg_urgent = '#ffffff'
-- theme.tasklist_fg_normal = '#AAAAAA'

-- Notification
theme.notification_position = 'top_right'
theme.notification_bg = theme.background
theme.notification_margin = dpi(5)
theme.notification_border_width = dpi(0)
theme.notification_border_color = theme.accent
theme.notification_spacing = dpi(5)
theme.notification_icon_resize_strategy = 'center'
theme.notification_icon_size = dpi(32)

-- -- Client Snap Theme
-- theme.snap_bg = theme.background
-- theme.snap_shape = gears.shape.rectangle
-- theme.snap_border_width = dpi(15)

-- Hotkey popup
theme.hotkeys_font = 'Inter Bold'
theme.hotkeys_description_font   = 'Inter Regular'
theme.hotkeys_bg = theme.background
theme.hotkeys_group_margin = dpi(20)
theme.hotkeys_border_width = dpi(1)
theme.hotkeys_border_color = theme.accent

-- wibar, basic
theme.wibar_border_width = dpi(0)
theme.wibar_height = dpi(30)
theme.wibar_bg = theme.background
theme.wibar_shape = gears.shape.rectangle

--wibar, extra
theme.wibar_extra_item_margin = dpi(5)
theme.wibar_extra_margin = dpi(3)
theme.wibar_extra_border_width = dpi(1)

return theme