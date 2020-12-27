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

function ScreenUtils:mouse_pressed()
    if love.mouse.isDown(1) then
        return true
    end
    return false
end

function ScreenUtils:get_mouse_click()
    local click = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }
    return click
end

function ScreenUtils:is_circle_clicked(circle, click)
    local bool_x = click.x < circle.x + circle.radians and click.x > circle.x - circle.radians
    local bool_y = click.y < circle.y + circle.radians and click.y > circle.y - circle.radians
    return bool_x and bool_y
end
