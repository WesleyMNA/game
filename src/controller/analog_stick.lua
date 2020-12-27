require("src.utils.color")
require("src.utils.screen")
require("src.utils.utils")
require("src.controller.stick")

AnalogStick = {}
AnalogStick.__index = AnalogStick

function AnalogStick:new(x)
    local this = {
        x = x,
        y = WINDOW_HEIGHT - 60,
        radians = 50,
        directions = {x = 0, y = 0},
        angle = 0
    }

    this.stick = Stick:new(x, this.y)

    setmetatable(this, self)
    return this
end

function AnalogStick:update(dt)
    self:reset_directions()
    self.stick:update(dt)

    if ScreenUtils:screen_touched() then
        local touches = love.touch.getTouches()
        for _, touch in pairs(touches) do
            local click = ScreenUtils:get_touch_click(touch)
            if ScreenUtils:is_circle_clicked(self, click) then
                self.stick:move(click)
                self:set_directions(click)
            end
        end
    end

    if ScreenUtils:mouse_pressed() then
        local click = ScreenUtils:get_mouse_click()
        if ScreenUtils:is_circle_clicked(self, click) then
            self.stick:move(click)
            self:set_directions(click)
        end
    end
end

function AnalogStick:render()
    ColorUtils:set_color(WHITE)
    love.graphics.circle("fill", self.x, self.y, self.radians)
    self.stick:render()
end

function AnalogStick:set_directions(click)
    local side_x = click.x - self.x
    local side_y = click.y - self.y
    local hypotenuse = math.sqrt(side_x ^ 2 + side_y ^ 2)

    self.directions.x = side_x / hypotenuse
    self.directions.y = side_y / hypotenuse
    self:set_angle(side_x, side_y)
end

function AnalogStick:set_angle(side_x, side_y)
    self.angle = math.atan2(side_y, side_x)
end

function AnalogStick:reset_directions()
    self.directions.x = 0
    self.directions.y = 0
end

function AnalogStick:is_moving()
    return self.directions.x ~= 0 or self.directions.y ~= 0
end
