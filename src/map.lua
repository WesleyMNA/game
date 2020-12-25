require('src.player.player')

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        background = love.graphics.newImage("assets/sprites/map/background.png"),
        player = Player:new(100, 100)
    }

    setmetatable(this, self)
    return this
end

function Map:update(dt)

end

function Map:render()
    love.graphics.draw(self.background)
end
