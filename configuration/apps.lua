local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local get_dpi = require('beautiful').xresources.get_dpi

return {
    -- The default applications that we will use in keybindings and widgets
    default = {
        -- Default terminal emulator
        terminal = 'kitty',
        -- Default web browser
        web_browser = 'firefox',
        -- Default text editor
        text_editor = 'code',
        -- Default file manager
        file_manager = 'nemo',
        -- Default media player
        multimedia = 'vlc',
        -- -- Default game, can be a launcher like steam
        -- game = 'supertuxkart',
        -- -- Default graphics editor
        -- graphics = 'gimp-2.10',
        -- -- Default sandbox
        -- sandbox = 'virtualbox',
        -- -- Default IDE
        -- development = '',
        -- -- Default network manager
        -- network_manager = 'kitty iwctl',
        -- -- Default bluetooth manager
        -- bluetooth_manager = 'blueman-manager',
        -- -- Default power manager
        -- power_manager = 'xfce4-power-manager',
        -- -- Default locker
        -- lock = 'awesome-client "awesome.emit_signal(\'module::lockscreen_show\')"',
        -- Default app menu
        rofi = 'rofi -dpi ' .. get_dpi() ..
               ' -show drun -theme ' .. config_dir .. '/configuration/rofi.rasi',
        -- Screenshot to the clipboard
        screenshot = 'flameshot full -c',
        region_screenshot = 'flameshot gui'
    },

    -- List of apps to start once on start-up
    run_on_start_up = {
        -- Compositor
        'picom -b --experimental-backends --dbus --config ' ..
        config_dir .. '/configuration/picom.conf',
        -- Keyboard layout switcher
        'setxkbmap -layout us,ru -option grp:caps_toggle',
        -- Typematic delay and rate
        'xset r rate 200 30',
        -- Screenhot maker
        'flameshot config --trayicon false',
        -- Load X colors
        'xrdb $HOME/.Xresources',

        -- -- Blueman applet
        -- 'blueman-applet',
        -- -- Music server
        -- 'mpd',
        -- -- Polkit and keyring
        -- '/usr/bin/lxqt-policykit-agent &' ..
        -- ' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',
        -- -- Audio equalizer
        -- 'pulseeffects --gapplication-service',
        -- -- Lockscreen timer
        -- [[
        -- xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
        -- "awesome-client 'awesome.emit_signal(\"module::lockscreen_show\")'" ""
        -- ]]
    }
}
