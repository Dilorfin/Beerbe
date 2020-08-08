local colliding = {}

function colliding:load(characterWidth, characterHeight)
    self.characterSize = {
        x = characterWidth,
        y = characterHeight
    }
end

function colliding:collide(moving, map)
    local x = math.floor((character.position.x/map:getTileSide()) + 1)
    local y = math.floor(character.position.y/map:getTileSide())
    
    self:collideWithObjects(moving, map)

    if (moving.speed.x < 0) -- left
        and (not map:isTilePassable(x, y)
        or not map:isTilePassable(x, y+1))
    then
        character.position.x = x * map:getTileSide() - 1
    elseif  (moving.speed.x > 0) -- right 
        and (not map:isTilePassable(x+1, y)
        or not map:isTilePassable(x+1, y+1))
    then
        character.position.x = (x-1) * map:getTileSide()
    end
    
    if (moving.speed.y < 0) -- up
        and (not map:isTilePassable(x, y)
        or not map:isTilePassable(x+1, y))
    then
        character.position.y = (y+1) * map:getTileSide() - 1
    elseif (moving.speed.y > 0) -- down
        and (not map:isTilePassable(x, y+1)
        or not map:isTilePassable(x+1, y+1))
    then
        character.position.y = y * map:getTileSide()
    end
end

function colliding:collideWithObjects(moving, map)
    local x = math.floor((character.position.x/map:getTileSide()) + 1)
    local y = math.floor(character.position.y/map:getTileSide())

    if map:getObject(x, y) then
        map:getObject(x, y):onCollide(moving)
    end
    if map:getObject(x+1, y) then
        map:getObject(x+1, y):onCollide(moving)
    end
    if map:getObject(x, y+1) then
        map:getObject(x, y+1):onCollide(moving)
    end
    if map:getObject(x+1, y+1) then
        map:getObject(x+1, y+1):onCollide(moving)
    end
end

return colliding