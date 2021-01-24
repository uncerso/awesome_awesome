utils = {}

utils.fix_tooltip_shape = function(tooltip)
    tooltip:get_wibox():set_shape(tooltip.widget:get_shape())
end

return utils