ScreenUtils = {}
ScreenUtils.__index = ScreenUtils

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

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

function ScreenUtils:mouse_pressed()
    if love.mouse.isDown(1) then
        return true
    end
    return false
end

function ScreenUtils:get_mouse_clicks()
    local clicks = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }
    return clicks
end