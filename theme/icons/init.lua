
-- Icons directory
local dir = require('gears.filesystem').get_configuration_dir() .. '/theme/icons/'


return {

	-- Action Bar
	web_browser 		= dir .. 'tag-list/tag/' .. 'firefox.png',
	-- text_editor			= dir .. 'tag-list/' .. 'text-editor.svg',
	social				= dir .. 'tag-list/tag/' .. 'forum.png',
	-- file_manager 		= dir .. 'tag-list/' .. 'file-manager.svg',
	-- multimedia 			= dir .. 'tag-list/' .. 'multimedia.svg',
	-- games 				= dir .. 'tag-list/' .. 'games.svg',
	development 		= dir .. 'tag-list/tag/' .. 'flask.png',
	-- sandbox 			= dir .. 'tag-list/' .. 'sandbox.svg',
	terminal 			= dir .. 'tag-list/tag/' .. 'code-braces.png',
	-- graphics 			= dir .. 'tag-list/' .. 'graphics.svg',
	-- menu 				= dir .. 'tag-list/' .. 'menu.svg',
	-- close_small 		= dir .. 'tag-list/' .. 'close-small.svg',

	-- Others/System UI
	close 				= dir .. 'close.svg',
	logout				= dir .. 'logout.svg',
	sleep 				= dir .. 'power-sleep.svg',
	power 				= dir .. 'power.svg',
	lock 				= dir .. 'lock.svg',
	restart 			= dir .. 'restart.svg',
	search 				= dir .. 'magnify.svg',
	volume 				= dir .. 'volume-high.svg',
	mute 				= dir .. 'mute.svg',
	brightness 			= dir .. 'brightness-7.svg',
	effects 			= dir .. 'effects.svg',
	chart 				= dir .. 'chart-areaspline.svg',
	memory 				= dir .. 'memory.svg',
	harddisk 			= dir .. 'harddisk.svg',
	thermometer 		= dir .. 'thermometer.svg',
	plus 				= dir .. 'plus.svg',
	batt_charging 		= dir .. 'battery-charge.svg',
	batt_discharging	= dir .. 'battery-discharge.svg',
	toggled_on 			= dir .. 'toggled-on.svg',
	toggled_off			= dir .. 'toggled-off.svg'

}
