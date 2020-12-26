require('src.player.player')
require("src.utils.color")


Map = {}
Map.__index = Map

function Map:new()
    local this = {
        background = love.graphics.newImage("assets/sprites/map/background.png"),
        player = Player:new(600, 600)
    }

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.player:update(dt)
end

function Map:render()
    ColorUtils:set_color(WHITE)
    love.graphics.draw(self.background)
    self.player:render()
end
