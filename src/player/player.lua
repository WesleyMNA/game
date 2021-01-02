require("src.utils.color")
require("src.player.bullet")

Player = {}
Player.__index = Player

function Player:new(x, y)
    local this = {
        sprite = love.graphics.newImage("assets/sprites/player/player.png"),
        x = x,
        y = y,
        radians = -1.55,
        scale_x = 1,
        scale_y = 1,
        offset_x = 32,
        offset_y = 32,
        speed = 200,
        collider = {},
        collision_range = 5,
        bullets = {}
    }

    this.collider.width = this.sprite:getWidth()
    this.collider.height = this.sprite:getHeight()
    this.collider.x = this.x - this.offset_x
    this.collider.y = this.y - this.offset_y

    setmetatable(this, self)
    return this
end

function Player:update(dt)
    Utils:update_loop(self.bullets, dt)
end

function Player:render()
    ColorUtils:set_color(WHITE)
    love.graphics.draw(
        self.sprite,
        self.x,
        self.y,
        self.radians,
        self.scale_x,
        self.scale_y,
        self.offset_x,
        self.offset_y
    )
    Utils:render_loop(self.bullets)

    ColorUtils:set_color(RED)
    love.graphics.rectangle("line", self.collider.x, self.collider.y, self.collider.width, self.collider.height)
end

function Player:move(directions, dt)
    self:check_collision(directions)
    self.x = self.x + self.speed * dt * directions.x
    self.y = self.y + self.speed * dt * directions.y
    self:move_collider()
end

function Player:attack(directions, radians)
    self.radians = radians
    if directions.x ~= 0 or directions.y ~= 0 then
        directions = Utils:copy(directions)
        table.insert(self.bullets, Bullet:new(self.x, self.y, directions))
    end
end

function Player:move_collider()
    self.collider.x = self.x - self.offset_x
    self.collider.y = self.y - self.offset_y
end

function Player:check_collision(directions)
    if not self:check_left_collision(directions.x) then
        directions.x = 0
    end
    if not self:check_right_collision(directions.x) then
        directions.x = 0
    end
    if not self:check_top_collision(directions.y) then
        directions.y = 0
    end
    if not self:check_bottom_collision(directions.y) then
        directions.y = 0
    end
end

function Player:check_left_collision(dx)
    if dx < 0 then
        if
            MAP:collides(MAP:tile_at(self.collider.x - self.collision_range, self.collider.y)) or
                MAP:collides(
                    MAP:tile_at(
                        self.collider.x - self.collision_range,
                        self.collider.y + self.collider.height - self.collision_range
                    )
                )
         then
            return false
        end
    end
    return true
end

function Player:check_right_collision(dx)
    if dx > 0 then
        if
            MAP:collides(MAP:tile_at(self.collider.x + self.collider.width + self.collision_range, self.collider.y)) or
                MAP:collides(
                    MAP:tile_at(
                        self.collider.x + self.collider.width + self.collision_range,
                        self.collider.y + self.collider.height - self.collision_range
                    )
                )
         then
            return false
        end
    end
    return true
end

function Player:check_top_collision(dy)
    if dy < 0 then
        if
            MAP:collides(MAP:tile_at(self.collider.x, self.collider.y - self.collision_range)) or
                MAP:collides(MAP:tile_at(self.collider.x + self.collider.width, self.collider.y - self.collision_range))
         then
            return false
        end
    end
    return true
end

function Player:check_bottom_collision(dy)
    if dy > 0 then
        if
            MAP:collides(MAP:tile_at(self.collider.x, self.collider.y + self.collider.height + self.collision_range)) or
                MAP:collides(
                    MAP:tile_at(
                        self.collider.x + self.collider.width,
                        self.collider.y + self.collider.height + self.collision_range
                    )
                )
         then
            return false
        end
    end
    return true
end
