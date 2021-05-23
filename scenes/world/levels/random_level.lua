local function createObjectsMap(map)
    -- objects
    for y = 1, map.height do
        for x = 1, map.width - 2 do
            if map:getCell(x, y).tile == 1 and love.math.random(0, 200) < 5 then
                -- small growths
                map.objectsMap:setObject(13, x, y)
            elseif map:getCell(x, y).tile == 1 and love.math.random(0, 100) < 15 then
                -- down-to-earth
                map.objectsMap:setObject(12, x, y)
            end
        end
    end
    for y = 2, map.height - 1 do
        for x = 2, map.width - 3 do
            -- big growths
            if map:getCell(x, y).tile == 1 and love.math.randomNormal() >= 2 then
                map.objectsMap:setObject(14, x, y)
            -- lamps
            elseif map:getCell(x, y).tile == 1 and love.math.random(0, 100) < 1 then
                map.objectsMap:setObject(1, x, y)
            end
        end
    end

    -- chests
    local chestsNumber = love.math.random(1, 2)
    for i = 1, chestsNumber do
        local x = love.math.random(math.ceil(2+map.width/3), map.width - 5)
        local y = love.math.random(2, map.height - 3)
        map.objectsMap:setObject(11, x, y)
    end

    -- dev lamps
    if math.abs(love.math.randomNormal()) >= 0.5 then
        local x = love.math.random(math.ceil(2+map.width/3), map.width - 5)
        local y = love.math.random(2, map.height - 2)
        
        map.objectsMap:setObject(8, x, y)
    end

    -- TODO: replace with more clever solution
    -- clear objects near player
    for y = map.spawnPosition.y - 1, map.spawnPosition.y + 1 do
        for x = map.spawnPosition.x - 1, map.spawnPosition.x + 2 do
            map.objectsMap:setObject(nil, x, y)
        end
    end

    -- clear objects near exit
    for y = map.exit.y - 1, map.exit.y + 1 do
        for x = map.exit.x - 2, map.exit.x do
            map.objectsMap:setObject(nil, x, y)
        end
    end

    -- doors
    map.objectsMap:setObject(15, 1, map.spawnPosition.y)
    map.objectsMap:setObject(2, map.exit.x, map.exit.y)
end

local function createMap(world, map)
    map.styleId = love.math.random(0, 6)
    map.width = love.math.random(18, 23)
    map.height = love.math.random(12, 18)

    map.spawnPosition = {
        x = 2,
        y = love.math.random(3, map.height-2)
    }

    map.exit = {
        x = map.width,
        y = love.math.random(3, map.height-2)
    }

    map.map = {}
    map.possibleEnemies = { 1, 2, 3 }

    -- tiles
    for i = map.width + 1, map.width*map.height do
        map.map[i] = { tile = 1, passable = true }
    end
    for i = 2, map.width - 1 do
        map.map[i] = { tile = 2 }
    end
    for i = 1, map.height do
        map.map[i*map.width] = { tile = 4 }
        map.map[(i-1)*map.width+1] = { tile = 3 }
    end
    
    createObjectsMap(map)

    local i = 0
    
    local e_number = love.math.random(1, character.position.level % 10)
    while i < e_number do
        local x = love.math.random(3, map.width-2)
        local y = love.math.random(3, map.height-2)
        local tileSide = map:getTileSide()
        if not map.objectsMap:getObject(x, y) then
            table.insert(map.movables, newMovableEnemy(world, tileSide*x, tileSide*y))
            i = i + 1
        end
    end
end

return createMap