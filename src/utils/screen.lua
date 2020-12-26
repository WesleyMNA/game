ScreenUtils = {}
ScreenUtils.__index = ScreenUtils

function ScreenUtils:screen_touched()
    if #love.touch.getTouches() == 0 then
        return false
    end
    return true
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

function ScreenUtils:is_circle_clicked(circle, clicks)
    local bool_x = clicks.x < circle.x + circle.radians and clicks.x > circle.x - circle.radians
    local bool_y = clicks.y < circle.y + circle.radians and clicks.y > circle.y - circle.radians
    return bool_x and bool_y
end
