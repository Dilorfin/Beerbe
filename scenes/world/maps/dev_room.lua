local function createMap(map)
    local tiles = {
        3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4, 
        3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4
    }

    map.map = {}
    for i = 1, #tiles do
        map.map[i] = { tile = tiles[i] }
    end
    
    map.width = 16
    
    map.spawnPosition = {
        x = 7,
        y = 10
    }
    map.styleId = 7

    map:setObject(3, 7, 5)
    map:setObject(4, 9, 6)
    map:setObject(5, 7, 7)
    map:setObject(6, 2, 1)
    map:setObject(7, 3, 2)
    
    map:setObject(9, 12, 1)
    map:setObject(10, 14, 3)
end

return createMap