require("src.map")
require("src.controller.controller")
require("src.utils.utils")
require("src.utils.screen")
require("src.utils.color")

require("lib.camera")

local controller

function love.load()
    MAP = Map:new()
    controller = Controller:new()
end

function love.update(dt)
    controller:update(dt)
    MAP:update(dt)

    Camera.x = math.floor(MAP.player.x - WINDOW_WIDTH / 2)
    Camera.y = math.floor(MAP.player.y - WINDOW_HEIGHT / 2)
end

function love.draw()
    Camera:set()
    MAP:render()
    Camera:unset()
    controller:render()
end
