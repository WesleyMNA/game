require('src.map')
require('src.controller.controller')
require('src.utils.utils')

require('lib.camera')

local map
local controller

function love.load()
    map = Map:new()
    controller = Controller:new(map.player)
end

function love.update(dt)
    controller:update(dt)
    map:update(dt)

    Camera.x = map.player.x - WINDOW_WIDTH/2
    Camera.y = map.player.y - WINDOW_HEIGHT/2
end

function love.draw()
    Camera:set()
    map:render()
    Camera:unset()
    controller:render()
end
