Controller = {}
Controller.__index = Controller

function Controller:new(player)
    local this = {
        player = player
    }

    setmetatable(this, self)
    return this
end

function Controller:update(dt)
    if love.keyboard.isDown("a") then
        self.player.x = self.player.x - self.player.speed * dt
    end
    if love.keyboard.isDown("d") then
        self.player.x = self.player.x + self.player.speed * dt
    end
    if love.keyboard.isDown("w") then
        self.player.y = self.player.y - self.player.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.player.y = self.player.y + self.player.speed * dt
    end

    if love.keyboard.isDown("left") then
        self.player.radians = self.player.radians - 5 * dt
    end
    if love.keyboard.isDown("right") then
        self.player.radians = self.player.radians + 5 * dt
    end
end

function Controller:render()

end
