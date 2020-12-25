WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

TILE_SIZE = 16

Util = {}
Util.__index = Util

function Util:render_loop(objectList)
    for _, object in pairs(objectList) do
        object:render()
    end
end

function Util:update_loop(dt, objectList)
    for _, object in pairs(objectList) do
        object:update(dt)
    end
end

function Util:copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[self:copy(k, s)] = self:copy(v, s) end
    return res
end

function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end