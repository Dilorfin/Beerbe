local spritesheet = {}
local objectsCollection = require "scenes/world/objects"

function spritesheet:load()
    self.image = love.graphics.newImage("asserts/world/1.png")
    self.tiles = {
        love.graphics.newQuad(24, 48+24, 48, 48, self.image:getDimensions()), -- usual floor
        love.graphics.newQuad(24, 4*48, 48, 48, self.image:getDimensions()), -- top border
        love.graphics.newQuad(48, 3*48+24, 48, 48, self.image:getDimensions()), -- left border
        love.graphics.newQuad(0, 3*48+24, 48, 48, self.image:getDimensions()), -- right border
    }
end

function spritesheet:drawTile(id, x, y)
    love.graphics.draw(self.image, self.tiles[id], x, y)
end

local map = {
    width = 28,
    map = { 
        { tile = 3}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 2}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}, 
        { tile = 3}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 1}, { tile = 4}
    },
    objects = {},
    spawnPosition = {
        x = 2,
        y = 2
    }
}

function map:load(character)
    spritesheet:load()
    
    self.height = math.ceil(#self.map/self.width)
    character.position.x = self.spawnPosition.x * self:getTileSide()
    character.position.y = self.spawnPosition.y * self:getTileSide()

    local obj = objectsCollection:loadObject(1, 5, 5)
    table.insert(self.objects, obj)
    for x = obj.position.x + 1, obj.position.x+obj.width do
        for y = obj.position.y, obj.position.y+obj.height - 1 do
            self:getCell(x, y).object = obj
        end
    end
end

function map:getCell(x, y)
    return self.map[(y-1)*self.width + x]
end

function map:getObject(x, y)
    return self:getCell(x, y).object
end

function map:isTilePassable(x, y)
    local cell = self:getCell(x, y)
    if (not cell) or (cell.object and (not cell.object.isPassable))
    then
        return false
    end
    return self:isTileIdPassable(cell.tile)
end

function map:isTileIdPassable(id)
    return id == 1
end

function map:getTileSide()
    return 48
end

function map:update(dt)
    for i = 1, #self.objects do
        self.objects[i]:update(dt)
    end
end

function map:draw(camera)
    for i = 1, #self.map do
        spritesheet:drawTile(self.map[i].tile, ((i-1)%self.width)*48, math.ceil(i/self.width)*48)
    end
    local tileSide = self:getTileSide()
    for i = 1, #self.objects do
        self.objects[i]:draw(tileSide)
    end
    
    -- debug
    if not debug then return end
    love.graphics.setColor(0, 1, 0)
    for i = 1, self.height+1 do
        love.graphics.rectangle("fill", 0, map:getTileSide()*i, map:getTileSide()*self.width, 2)
    end
    for i = 0, self.width+1 do
        love.graphics.rectangle("fill", map:getTileSide()*i, map:getTileSide(), 2, map:getTileSide()*self.height)
    end
    love.graphics.setColor(1, 1, 1)
end

return map