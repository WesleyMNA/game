require("src.utils.color")

Player = {}
Player.__index = Player

function Player:new(x, y)
    local this = {
        sprite = love.graphics.newImage("assets/sprites/player/player.png"),
        x = x,
        y = y,
        radians = -1.55,
        scale_x = 1,
        scale_y = 1,
        offset_x = 32,
        offset_y = 32,
        speed = 200
    }

    setmetatable(this, self)
    return this
end

function Player:update(dt)
end

function Player:render()
    ColorUtils:set_color(WHITE)
    love.graphics.draw(
        self.sprite,
        self.x,
        self.y,
        self.radians,
        self.scale_x,
        self.scale_y,
        self.offset_x,
        self.offset_y
    )
end

function Player:move(directions, dt)
    self.x = self.x + self.speed * dt * directions.x
    self.y = self.y + self.speed * dt * directions.y
end

function Player:rotate(radians)
    self.radians = radians
end
