local colliding = {

}

function colliding:load(characterWidth, characterHeight)
    self.characterSize = {
        x = characterWidth,
        y = characterHeight
    }
end

function colliding:collide(moving, map, character)
    local x = math.floor((character.position.x/map:getTileSide())+ 1)
    local y = math.floor(character.position.y/map:getTileSide())
    
    if (moving.speed.x < 0)
        and (not map:isTilePassable(x, y)
        or not map:isTilePassable(x, y+1))
    then
        character.position.x = x * map:getTileSide()
    elseif  (moving.speed.x > 0)
        and (not map:isTilePassable(x+1, y)
        or not map:isTilePassable(x+1, y+1))
    then
        character.position.x = (x-1) * map:getTileSide()
    end
    
    if (moving.speed.y < 0)
        and (not map:isTilePassable(x, y)
        or not map:isTilePassable(x+1, y))
    then
        character.position.y = (y+1) * map:getTileSide()
    elseif (moving.speed.y > 0)
        and (not map:isTilePassable(x, y+1)
        or not map:isTilePassable(x+1, y+1))
    then
        character.position.y = y * map:getTileSide()
    end
end

return colliding