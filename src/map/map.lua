require("src.player.player")
require("src.utils.color")
require("src.map.tiles")
require("src.utils.image")

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        spritesheet = love.graphics.newImage("assets/sprites/map/spritesheet.png"),
        player = Player:new(100, 100),
        background = {},
        width = 100,
        height = 100
    }

    this.quads = ImageUtils:generate_quads(this.spritesheet, TILES.width, TILES.height)

    this.sprite_batch = love.graphics.newSpriteBatch(this.spritesheet, this.width * this.height)
    setmetatable(this, self)

    this:generate_background()
    this:refresh_sprite_batch()

    return this
end

function Map:update(dt)
    self.player:update(dt)
end

function Map:render()
    ColorUtils:set_color(WHITE)
    love.graphics.draw(self.sprite_batch)
    self.player:render()
end

function Map:generate_background()
    for x = 1, self.width do
        for y = 1, self.height do
            if x == 1 or y == 1 or x == self.width or y == self.height then
                self:set_tile(x, y, TILES.wall)
            elseif math.random(50) == 1 then
                self:set_tile(x, y, TILES.box)
            else
                self:set_tile(x, y, TILES.grass)
            end
        end
    end
end

function Map:refresh_sprite_batch()
    self.sprite_batch = love.graphics.newSpriteBatch(self.spritesheet, self.width * self.height)
    for y = 1, self.height do
        for x = 1, self.width do
            self.sprite_batch:add(self.quads[self:get_tile(x, y)], (x - 1) * TILES.width, (y - 1) * TILES.height)
        end
    end
end

function Map:collides(tile)
    for _, collidable in ipairs(TILES.collidables) do
        if tile == collidable then
            return true
        end
    end
    return false
end

function Map:tile_at(x, y)
    return self:get_tile(math.floor(x / TILES.width) + 1, math.floor(y / TILES.height) + 1)
end

function Map:get_tile(x, y)
    return self.background[(y - 1) * self.width + x]
end

function Map:set_tile(x, y, tile)
    self.background[(y - 1) * self.width + x] = tile
end
