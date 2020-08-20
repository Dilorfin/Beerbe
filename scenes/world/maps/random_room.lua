local function createMap(map)
    character = require "character"

    map.styleId = love.math.random(1, 6)
    map.width = love.math.random(18, 23)
    map.height = love.math.random(12, 18)

    map.fightFrequency = (map.height * map.width / 48) - 1

    map.spawnPosition = {
        x = 1,
        y = love.math.random(3, map.height-2)
    }

    local exit = {
        x = map.width-1,
        y = love.math.random(3, map.height-2)
    }

    map.map = {}
    
    -- tiles
    for i = map.width + 1, map.width*map.height do
        map.map[i] = { tile = 1 }
    end
    for i = 2, map.width - 1 do
        map.map[i] = { tile = 2 }
    end
    for i = 1, map.height do
        map.map[i*map.width] = { tile = 4 }
        map.map[(i-1)*map.width+1] = { tile = 3 }
    end
    
    -- objects
    for y = 1, map.height do
        for x = 1, map.width - 2 do
            if map:getCell(x, y).tile == 1 and love.math.random(0, 200) < 5 then
                map:setObject(13, x, y, map.styleId)
            elseif map:getCell(x, y).tile == 1 and love.math.random(0, 100) < 15 then
                map:setObject(12, x, y, map.styleId)
            end
        end
    end
    for y = 2, map.height - 1 do
        for x = 2, map.width - 3 do
            -- big growths
            if map:getCell(x, y).tile == 1 and love.math.randomNormal() >= 2 then
                map:removeObject(x, y)
                map:setObject(14, x, y, map.styleId)
            -- lamps
            elseif map:getCell(x, y).tile == 1 and love.math.random(0, 100) < 1 then
                map:setObject(1, x, y, map.styleId)
            end
        end
    end
    
    -- chests
    local chestsNumber = love.math.random(1, 2)
    for i = 1, chestsNumber do
        local x = love.math.random(math.ceil(2+map.width/3), map.width - 5)
        local y = love.math.random(2, map.height - 3)
        map:removeObject(x, y)
        map:setObject(11, x, y)
    end

    -- dev lamps
    if math.abs(love.math.randomNormal()) >= 0.5 then
        local x = love.math.random(math.ceil(2+map.width/3), map.width - 5)
        local y = love.math.random(2, map.height - 2)
        map:removeObject(x, y)
        map:setObject(8, x, y)
    end

    -- clear objects near player
    for y = map.spawnPosition.y - 1, map.spawnPosition.y + 1 do
        for x = map.spawnPosition.x - 1, map.spawnPosition.x + 2 do
            map:removeObject(x, y)
        end
    end

    -- clear objects near exit
    for y = exit.y - 1, exit.y + 1 do
        for x = exit.x - 2, exit.x do
            map:removeObject(x, y)
        end
    end
    
    -- other objects

    -- doors
    map:setObject(15, 0, map.spawnPosition.y)
    map:setObject(2, exit.x, exit.y)
end

return createMap