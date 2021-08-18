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
		-- left room
		{
			x = 48,
			y = 0,
			width = 48*12,
			height = 48
		},
		{
			x = 0,
			y = 48,
			width = 48,
			height = 48*8
		},
		{
			x = 48,
			y = 48*9,
			width = 48*12,
			height = 48
		},
		{
			x = 48*13,
			y = 48,
			width = 48*2,
			height = 48*5
		},
		{
			x = 48*13,
			y = 48*7,
			width = 48*2,
			height = 48*4
		},
		-- center room
		{
			x = 48*15,
			y = 48*11,
			width = 48*14,
			height = 48
		},
		{
			x = 48*15,
			y = 48,
			width = 48*14,
			height = 48
		},
		{
			x = 48*29,
			y = 48*2,
			width = 48*2,
			height = 48*4
		},
		{
			x = 48*29,
			y = 48*7,
			width = 48*2,
			height = 48*4
		},
		-- right room
		{
			x = 48*31,
			y = 48*3,
			width = 48*6,
			height = 48
		},
		{
			x = 48*31,
			y = 48*9,
			width = 48*6,
			height = 48
		},
		{
			x = 48*37,
			y = 48*4,
			width = 48,
			height = 48*5
		},
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