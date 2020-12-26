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
        directions = {x = 0, y = 0}
    }

    this.stick = Stick:new(x, this.y)

    setmetatable(this, self)
    return this
end

function AnalogStick:update(dt)
    self:reset_directions()
    self.stick:update(dt)

    -- if Utils:screen_touched() then
    --     local touches = love.touch.getTouches()
    --     for _, touch in touches do
    --         local x, y = love.touch.getPosition(touch)
    --     end
    -- end

    if ScreenUtils:mouse_pressed() then
        local clicks = ScreenUtils:get_mouse_clicks()
        if ScreenUtils:is_circle_clicked(self, clicks) then
            self.stick:move(clicks)
            self:set_directions(clicks)
        end
    end
end

function AnalogStick:render()
    ColorUtils:set_color(WHITE)
    love.graphics.circle("fill", self.x, self.y, self.radians)
    self.stick:render()
end

function AnalogStick:set_directions(clicks)
    local side_x = clicks.x - self.x
    local side_y = clicks.y - self.y
    local hypotenuse = math.sqrt(side_x ^ 2 + side_y ^ 2)

    self.directions.x = side_x / hypotenuse
    self.directions.y = side_y / hypotenuse
end

function AnalogStick:reset_directions()
    self.directions.x = 0
    self.directions.y = 0
end

function AnalogStick:is_moving()
    return self.directions.x ~= 0 or self.directions.y ~= 0
end
