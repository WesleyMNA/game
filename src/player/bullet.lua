Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, directions)
    local this = {
        x = x,
        y = y,
        directions = directions,
        speed = 400
    }

    setmetatable(this, self)
    return this
end

function Bullet:update(dt)
    self:move(dt)
end

function Bullet:render()
    ColorUtils:set_color(BLACK)
    love.graphics.circle("fill", self.x, self.y, 2)
end

function Bullet:move(dt)
    self.x = self.x + self.speed * self.directions.x * dt
    self.y = self.y + self.speed * self.directions.y * dt
end