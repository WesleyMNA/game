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
        angle = 0,
        touch_id = nil
    }

    this.stick = Stick:new(x, this.y)

    setmetatable(this, self)
    return this
end

function AnalogStick:update(dt)
    self.stick:update(dt)
    if self.touch_id then
        local click = ScreenUtils:get_touch_click(self.touch_id)
        self.stick:move(click)
        self:set_directions(click)
    else
        self:reset_directions()
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

function AnalogStick:reset_directions()
    self.directions.x = 0
    self.directions.y = 0
end

function AnalogStick:set_angle(side_x, side_y)
    self.angle = math.atan2(side_y, side_x)
end

function AnalogStick:is_clicked(click)
    local bool_x = click.x < self.x + self.radians and click.x > self.x - self.radians
    local bool_y = click.y < self.y + self.radians and click.y > self.y - self.radians
    return bool_x and bool_y
end

function AnalogStick:set_touch(touch_id, click)
    if self:is_clicked(click) then
        self.touch_id = touch_id
    end
end

function AnalogStick:reset_touch(touch_id)
    if self.touch_id == touch_id then
        self.touch_id = nil
    end
end
