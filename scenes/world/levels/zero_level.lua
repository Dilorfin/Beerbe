local level_data = {
	id = 0,
	styleId = 8,
	possibleEnemies = { 1, 2, 3 },
	width = 40, -- in tiles
	height = 10, -- in tiles
	tiles = {
		10,10,10,10,10,10,10,10,10,10,10,10,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		10,6,4,4,4,4,4,4,4,4,7,10,nil,nil,10,10,10,10,10,10,10,10,10,10,10,10,10,10,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		10,2,1,1,1,1,1,1,1,1,3,10,nil,nil,10,6,4,4,4,4,4,4,4,4,4,4,7,10,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		10,2,1,1,1,1,1,1,1,1,3,10,nil,nil,10,2,1,1,1,1,1,1,1,1,1,1,3,10,nil,nil,10,10,10,10,10,10,nil,nil,nil,nil,
		10,2,1,1,1,1,1,1,1,1,3,10,nil,nil,10,2,1,1,1,1,1,1,1,1,1,1,3,10,nil,nil,10,6,4,4,7,10,nil,nil,nil,nil,
		10,2,1,1,1,1,1,1,1,1,3,10,10,10,10,2,1,1,1,1,1,1,1,1,1,1,3,10,10,10,10,2,1,1,3,10,nil,nil,nil,nil,
		10,8,5,5,5,5,5,5,5,5,9,10,nil,nil,10,2,1,1,1,1,1,1,1,1,1,1,3,10,nil,nil,10,8,5,5,9,10,nil,nil,nil,nil,
		10,10,10,10,10,10,10,10,10,10,10,10,nil,nil,10,2,1,1,1,1,1,1,1,1,1,1,3,10,nil,nil,10,10,10,10,10,10,nil,nil,nil,nil,
		nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,10,8,5,5,5,5,5,5,5,5,5,5,9,10,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,10,10,10,10,10,10,10,10,10,10,10,10,10,10,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
	},
	walls = {
--[[		{
			x = 96,
			y = 48,
			width = 48*14,
			height = 48
		},
		]]
	},
	player = {
		x = 1030, -- in px
		y = 250
	},
	cameraPosition = {
		x = 260,
		y = 13
	},
	enemies = {
		--{
		--	-- ids ???
		--	x = 5*48,
		--	y = 7*48
		--}
	},
	objects = {
		--[[{
			id = 3,
			x = 8*48, -- in px
			y = 5*48
		},
]]
	}
}

return level_data