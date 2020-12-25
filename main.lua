require('src.map')
require('src.controller.controller')

local map
local controller

function love.load()
    map = Map:new()
    controller = Controller:new(map.player)
end

function love.update(dt)
    map:update(dt)
    controller:update(dt)
end

function love.draw()
    map:render()
    controller:render()
end
