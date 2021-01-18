local top_panel = require('layout.top-panel')
-- local control_center = require('layout.control-center')
-- local info_center = require('layout.info-center')

-- Create a wibox panel for each screen and add it
screen.connect_signal(
	'request::desktop_decoration',
	function(s)
		s.top_panel = top_panel(s)
		-- s.control_center = control_center(s)
		-- s.info_center = info_center(s)
		-- s.control_center_show_again = false
		-- s.info_center_show_again = false
	end
)
