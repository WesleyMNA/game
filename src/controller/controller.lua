require("src.utils.utils")
require("src.controller.analog_stick")

Controller = {}
Controller.__index = Controller

local attack_y = WINDOW_HEIGHT - 60

function Controller:new()
    local this = {
        player = MAP.player,
        move_stick = AnalogStick:new(60),
        attack_stick = AnalogStick:new(WINDOW_WIDTH - 60)
    }

    setmetatable(this, self)
    return this
end

function Controller:update(dt)
    self.move_stick:update(dt)
    self.attack_stick:update(dt)

    -- code for testing while developing
    if love.keyboard.isDown("a") then
        self.move_stick.directions.x = -1
    end
    if love.keyboard.isDown("d") then
        self.move_stick.directions.x = 1
    end
    if love.keyboard.isDown("w") then
        self.move_stick.directions.y = -1
    end
    if love.keyboard.isDown("s") then
        self.move_stick.directions.y = 1
    end

    self.player:move(self.move_stick.directions, dt)
    self.player:rotate(self.attack_stick.angle)

    function love.touchpressed(id, x, y)
        local click = ScreenUtils:get_touch_click(id)
        self.move_stick:set_touch(id, click)
        self.attack_stick:set_touch(id, click)
    end

    function love.touchreleased(id)
        self.move_stick:reset_touch(id)
        self.attack_stick:reset_touch(id)
    end
end

function Controller:render()
    self.move_stick:render()
    self.attack_stick:render()
end
