local spritesheet = {}
local objectsCollection = require "scenes/world/objects"

function spritesheet:load(styleId)
    self.image = love.graphics.newImage("assets/world/tiles.png")
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

local function createWall(world, x, y, w, h)
    local wall = {}
    wall.body = love.physics.newBody(world, x, y, "static")
    wall.shape = love.physics.newRectangleShape(w/2, h/2, w, h)
    wall.fixture = love.physics.newFixture(wall.body, wall.shape)
    return wall
end

local map = {}

function map:load(world)
    self.movables = {}
    self.objects = {}
    self.objectsMap = {
        map = {},
        setObject = function(self, id, x, y)
            self.map[(y-1)*map.width + x] = id
        end,
        getObject = function(self, x, y)
            return self.map[(y-1)*map.width + x]
        end
    }

    if not character.position.dev then
        love.filesystem.load("scenes/world/maps/random_room.lua")()(world, self)
    else
        love.filesystem.load("scenes/world/maps/dev_room.lua")()(world, self)
    end

    spritesheet:load(self.styleId or 1)

    character.position.x = self.spawnPosition.x * self:getTileSide()
    character.position.y = self.spawnPosition.y * self:getTileSide()

    -- spawn objects
    local objInitData = {
        world = world,
        styleId = self.styleId
    }
    for x = 1, self.width do
        for y = 1, self.height do
            local obj = self.objectsMap:getObject(x, y)
            if obj then
                self:setObject(obj, x, y, objInitData)
            end
        end
    end
    
    map.walls = {
        createWall(world, 2*map:getTileSide(), map:getTileSide(), map:getTileSide()*(map.width-1), map:getTileSide()),               -- top
        createWall(world, map:getTileSide(), 2*map:getTileSide(), map:getTileSide(), map:getTileSide()*(map.height-1)),              -- left
        createWall(world, 2*map:getTileSide(), map:getTileSide()*(map.height+1), map:getTileSide()*(map.width-1), map:getTileSide()),-- bottom
        createWall(world, map:getTileSide()*map.width, 2*map:getTileSide(), map:getTileSide(), map:getTileSide()*(map.height-1))     --right
    }

    table.insert(self.movables, 1, newMovableHero(world))
end

function map:pause()
    for i = 1, #self.movables do
        self.movables[i]:pause()
    end
end

function map:unload()
    self.objects = {}
    self.map = {}
    self.movables = {}
    spritesheet:unload()
end

function map:getCell(x, y)
    if not self.map or x <= 0 or x > self.width then
        return nil
    end
    return self.map[(y-1)*self.width + x]
end

function map:setObject(id, x, y, initData)
    local obj = objectsCollection:loadObject(id, x*self:getTileSide(), y*self:getTileSide(), initData)

    table.insert(self.objects, obj)

    for ix = x + 1, x + obj.width do
        for iy = y, y + obj.height - 1 do
            if not obj.isPassable then
                self:getCell(ix, iy).passable = false
            end
        end
    end
end

function map:isTilePassable(x, y)
    local cell = self:getCell(x, y)
    if (not cell) or (not cell.passable) then
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

    self.movables[1]:update(dt)
    local i = 2
    while i <= #self.movables do
        if not self.movables[i].isDestroyed then
            self.movables[i]:update(dt)
            i = i + 1
        else
            self.movables[i]:destroy()
            table.remove(self.movables, i)
        end
    end
end

function map:draw(camera)
    local tileSide = self:getTileSide()
    local view = camera:getViewport()

    for x = math.floor(view.left/tileSide), math.floor(view.right/tileSide) do
        for y = math.floor(view.top/tileSide), math.floor(view.bottom/tileSide) do
            local cell = self:getCell(x, y)
            if cell then
                spritesheet:drawTile(cell.tile, x * tileSide, y * tileSide)
            end
        end
    end
    
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
    for i = 1, #self.walls do
        love.graphics.polygon("line", self.walls[i].body:getWorldPoints(self.walls[i].shape:getPoints()))
    end
    for i = 1, #self.movables do
        self.movables[i]:draw(camera)
    end
end

return map