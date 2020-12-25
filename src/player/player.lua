Player = {}
Player.__index = Player

function Player:new(x, y)
    local this = {
        sprite = love.graphics.newImage("assets/sprites/player/player.png"),
        x = x,
        y = y,
        radians = 0,
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
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end

    if love.keyboard.isDown("left") then
        self.radians = self.radians - 5 * dt
    end
    if love.keyboard.isDown("right") then
        self.radians = self.radians + 5 * dt
    end
end

function Player:render()
    love.graphics.draw(
        self.sprite, self.x, self.y, self.radians,
        self.scale_x, self.scale_y, self.offset_x, self.offset_y
    )
end
