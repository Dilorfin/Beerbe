local function createMap(world, map)
	map.map = {
		3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,nil,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4
	}
	map.width = 16
	map.height = math.ceil(#map.map/map.width)
	
	map.possibleEnemies = {}
	map.spawnPosition = {
		x = 8,
		y = 10
	}
	map.styleId = 7

	map.objectsMap:setObject(3, 8, 5)
	map.objectsMap:setObject(4, 10, 6)
	map.objectsMap:setObject(5, 8, 7)
	map.objectsMap:setObject(6, 3, 1)
	map.objectsMap:setObject(7, 4, 2)

	map.objectsMap:setObject(9, 13, 1)
	map.objectsMap:setObject(10, 15, 3)
end

return createMap