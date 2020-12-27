Stick = {}
Stick.__index = Stick

function Stick:new(x, y)
    local this = {
        x = x,
        y = y,
        middle_point = {
            x = x,
            y = y
        },
        radians = 15
    }

    setmetatable(this, self)
    return this
end

function Stick:update(dt)
    self.x = self.middle_point.x
    self.y = self.middle_point.y
end

function Stick:render()
    ColorUtils:set_color(BLACK)
    love.graphics.circle("fill", self.x, self.y, self.radians)
end

function Stick:move(click)
    self.x = click.x
    self.y = click.y
end
