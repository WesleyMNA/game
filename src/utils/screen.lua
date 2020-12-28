ScreenUtils = {}
ScreenUtils.__index = ScreenUtils

function ScreenUtils:screen_touched()
    if #love.touch.getTouches() == 0 then
        return false
    end
    return true
end

function ScreenUtils:get_touch_click(touch)
    local click = {}
    click.x, click.y = love.touch.getPosition(touch)
    return click
end
