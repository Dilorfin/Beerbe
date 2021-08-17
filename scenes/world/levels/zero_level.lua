local level_data = {
	id = 0,
	styleId = 7,
	possibleEnemies = { 1, 2, 3 },
	width = 28, -- in tiles
	height = 11, -- in tiles
	tiles = {
		3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,1,1,1,1,1,1,1,1,1,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
	},
	walls = {
		{ -- top
			x = 96,
			y = 48,
			width = 48*14,
			height = 48
		},
		{ -- bottom
			x = 96,
			y = 48*12,
			width = 48*14,
			height = 48
		},
		{ -- left
			x = 48,
			y = 96,
			width = 48,
			height = 48*10
		},
		{ -- right
			x = 48*16,
			y = 96,
			width = 48,
			height = 48*4
		},
		{ 
			x = 48*16,
			y = 96+48*5,
			width = 48,
			height = 48*5
		},
		{ -- corridor
			x = 48*17,
			y = 48*7,
			width = 48*2,
			height = 48*1
		},
		{
			x = 48*17,
			y = 48*5,
			width = 48*2,
			height = 48*1
		},
		{ -- top
			x = 96+48*18,
			y = 48*2,
			width = 48*9,
			height = 48
		},
		{ -- bottom
			x = 96+48*18,
			y = 48*10,
			width = 48*9,
			height = 48
		},
		{ -- right
			x = 48*29,
			y = 48*3,
			width = 48,
			height = 48*7
		},
		{ -- left
			x = 48+48*18,
			y = 48*3,
			width = 48,
			height = 48*3
		},
		{ 
			x = 48+48*18,
			y = 96+48*5,
			width = 48,
			height = 48*3
		},
	},
	player = {
		x = 8*48, -- in px
		y = 8*48+15
	},
	cameraPosition = {
		x = 33.5,
		y = 10
	},
	enemies = {
		--{
		--	-- ids ???
		--	x = 5*48,
		--	y = 7*48
		--}
	},
	objects = {
		{
			id = 3,
			x = 8*48, -- in px
			y = 5*48
		},

		{
			id = 4,
			x = 10*48,
			y = 6*48
		},
		{
			id = 5,
			x = 8*48,
			y = 7*48
		},
		{
			id = 6,
			x = 3*48,
			y = 1*48
		},
		{
			id = 7,
			x = 4*48,
			y = 2*48
		},
		{
			id = 9,
			x = 13*48,
			y = 1*48
		},
		{
			id = 10,
			x = 15*48,
			y = 3*48
		},
		{-- door
			id = 2,
			x = 16*48,
			y = 6*48
		},
	}
}

return level_data