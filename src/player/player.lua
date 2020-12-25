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

end

function Player:render()
    love.graphics.draw(
        self.sprite, self.x, self.y, self.radians,
        self.scale_x, self.scale_y, self.offset_x, self.offset_y
    )
end
