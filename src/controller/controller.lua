require('src.utils.utils')
require("src.controller.analog_stick")

Controller = {}
Controller.__index = Controller

local attack_y = WINDOW_HEIGHT - 60

function Controller:new(player)
    local this = {
        player = player,
        move_stick = AnalogStick:new(60),
        attack_stick = AnalogStick:new(WINDOW_WIDTH - 60)
    }

    setmetatable(this, self)
    return this
end

function Controller:update(dt)
    self.move_stick:update(dt)
    self.attack_stick:update(dt)

    if self.move_stick:is_moving() then
        self.player:move(self.move_stick.directions, dt)
    end

    if self.attack_stick:is_moving() then
        self.player:rotate(self.attack_stick.angle)
    end

    -- code for testing while developing
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
    self.move_stick:render()
    self.attack_stick:render()
end
