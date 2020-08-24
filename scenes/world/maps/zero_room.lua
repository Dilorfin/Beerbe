local function createMap(map)
    local tiles = {
        3,2,2,2,2,2,2,2,2,2,2,2,2,2,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,4
    }

    map.map = {}
    for i = 1, #tiles do
        map.map[i] = { tile = tiles[i] }
    end
    
    map.width = 15
    map.height = math.ceil(#map.map/map.width)
    
    map.spawnPosition = {
        x = 7,
        y = 10
    }
    map.styleId = 2

    -- chest
    map:setObject(16, 9, 2)
    -- lamps
    for i = 1, 5 do
        map:setObject(1, 2*i, 1)
        map:setObject(1, 1, i*2)
    end
    map:setObject(1, 2*6, 1)
    for i = 1, 2 do
        map:setObject(1, 13, i*2)
        map:setObject(1, 13, 6+i*2)
    end
    
    map:setObject(2, 14, 7)
end

return createMap