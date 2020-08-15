local spritesheet = {}
local objectsCollection = require "scenes/world/objects"

debug = false

function spritesheet:load(styleId)
    self.image = love.graphics.newImage("asserts/world/tiles.png")
    self.tiles = {
        love.graphics.newQuad(styleId*96 + 24, 48+24, 48, 48, self.image:getDimensions()), -- usual floor
        love.graphics.newQuad(styleId*96 + 24, 4*48, 48, 48, self.image:getDimensions()), -- top border
        love.graphics.newQuad(styleId*96 + 48, 3*48+24, 48, 48, self.image:getDimensions()), -- left border
        love.graphics.newQuad(styleId*96, 3*48+24, 48, 48, self.image:getDimensions()), -- right border
    }
end
function spritesheet:unload()
    self.image = nil
    self.tiles = nil
end
function spritesheet:drawTile(id, x, y)
    love.graphics.draw(self.image, self.tiles[id], x, y)
end

local map = {}

function map:load(character)
    self.objects = {}
    
    love.filesystem.load("scenes/world/maps/dev_room.lua")()(self)

    spritesheet:load(self.styleId or 1)

    self.fightFrequency = self.fightFrequency or 4294967296 -- ~int max seconds
    
    self.height = math.ceil(#self.map/self.width)

    character.position.x = self.spawnPosition.x * self:getTileSide()
    character.position.y = self.spawnPosition.y * self:getTileSide()
end

function map:unload()
    self.objects = nil
    self.map = nil
    spritesheet:unload()
end

function map:getCell(x, y)
    return self.map[(y-1)*self.width + x]
end

function map:getObject(x, y)
    local cell = self:getCell(x, y)
    if cell then 
        return cell.object 
    end
    return nil
end

function map:setObject(id, x, y)
    local obj = objectsCollection:loadObject(id, x, y)
    table.insert(self.objects, obj)
    for x = obj.position.x + 1, obj.position.x+obj.width do
        for y = obj.position.y, obj.position.y+obj.height - 1 do
            self:getCell(x, y).object = obj
        end
    end
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

function map:getFightFrequency()
    return self.fightFrequency
end

function map:update(dt)
    for i = 1, #self.objects do
        self.objects[i]:update(dt)
    end
end

function map:draw()
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