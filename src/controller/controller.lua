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
    self.player:update(dt)
end

function Controller:render()
    self.player:render()
end
