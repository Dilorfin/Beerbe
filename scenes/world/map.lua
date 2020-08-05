local spritesheet = {}

function spritesheet:load()
    self.image = love.graphics.newImage("asserts/world/1.png")
    self.tiles = {
        love.graphics.newQuad(24, 48+24, 48, 48, self.image:getDimensions()),
        love.graphics.newQuad(24, 4*48, 48, 48, self.image:getDimensions()),
        love.graphics.newQuad(48, 3*48+24, 48, 48, self.image:getDimensions()),
        love.graphics.newQuad(0, 3*48+24, 48, 48, self.image:getDimensions()),
    }
end

function spritesheet:drawTile(id, x, y)
    love.graphics.draw(self.image, self.tiles[id], x, y)
end

function spritesheet:drawObject(id, x, y)
    
end

local map = {
    width = 28,
    map = { 
        3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
        3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
    },
    objects = {},
    spawnPosition = {
        x = 144,
        y = 144
    }
}

function map:load(character)
    spritesheet:load()
    character.position.x=self.spawnPosition.x
    character.position.y=self.spawnPosition.y
end

function map:getTile(x, y)
    return self.map[y*self.width + x]
end

function map:update(dt)
end

function map:draw(camera)
    for i = 1, #self.map do
        spritesheet:drawTile(self.map[i], ((i-1)%self.width)*48, math.ceil(i/self.width)*48)
    end   
end

return map