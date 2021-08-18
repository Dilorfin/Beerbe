local level_data = {
	id = 0,
	styleId = 8,
	possibleEnemies = { 1, 2, 3 },
	width = 41, -- in tiles
	height = 12, -- in tiles
	tiles = {
		11,15,15,15,15,15,15,15,15,15,15,15,15,11,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		13,10,10,10,10,10,10,10,10,10,10,10,10,12,11,15,15,15,15,15,15,15,15,15,15,15,15,15,15,11,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		13,10,6,4,4,4,4,4,4,4,4,7,10,12,13,10,10,10,10,10,10,10,10,10,10,10,10,10,10,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		13,10,2,1,1,1,1,1,1,1,1,3,10,12,13,10,6,4,4,4,4,4,4,4,4,4,4,7,10,12,11,15,15,15,15,15,15,11,nil,nil,nil,
		13,10,2,1,1,1,1,1,1,1,1,3,10,12,13,10,2,1,1,1,1,1,1,1,1,1,1,3,10,12,13,10,10,10,10,10,10,12,nil,nil,nil,
		13,10,2,1,1,1,1,1,1,1,1,3,10,18,19,10,2,1,1,1,1,1,1,1,1,1,1,3,10,18,19,10,6,4,4,7,10,12,nil,nil,nil,
		13,10,2,1,1,1,1,1,1,1,1,3,10,10,10,10,2,1,1,1,1,1,1,1,1,1,1,3,10,10,10,10,2,1,1,3,10,12,nil,nil,nil,
		13,10,8,5,5,5,5,5,5,5,5,9,10,16,17,10,2,1,1,1,1,1,1,1,1,1,1,3,10,12,13,10,8,5,5,9,10,12,nil,nil,nil,
		13,10,10,10,10,10,10,10,10,10,10,10,10,12,13,10,2,1,1,1,1,1,1,1,1,1,1,3,10,12,13,10,10,10,10,10,10,12,nil,nil,nil,
		20,20,20,20,20,20,20,20,20,20,20,20,20,20,13,10,8,5,5,5,5,5,5,5,5,5,5,9,10,12,20,20,20,20,20,20,20,20,nil,nil,nil,
		nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,13,10,10,10,10,10,10,10,10,10,10,10,10,10,10,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
		nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,
	},
	walls = {
		-- left room
		{
			x = 48*2,
			y = 48,
			width = 48*12,
			height = 48
		},
		{
			x = 48,
			y = 48*2,
			width = 48,
			height = 48*8
		},
		{
			x = 48*2,
			y = 48*10,
			width = 48*12,
			height = 48
		},
		{
			x = 48*14,
			y = 48*2,
			width = 48*2,
			height = 48*5
		},
		{
			x = 48*14,
			y = 48*8,
			width = 48*2,
			height = 48*4
		},
		-- center room
		{
			x = 48*16,
			y = 48*12,
			width = 48*14,
			height = 48
		},
		{
			x = 48*16,
			y = 48*2,
			width = 48*14,
			height = 48
		},
		{
			x = 48*30,
			y = 48*3,
			width = 48*2,
			height = 48*4
		},
		{
			x = 48*30,
			y = 48*8,
			width = 48*2,
			height = 48*4
		},
		-- right room
		{
			x = 48*32,
			y = 48*4,
			width = 48*6,
			height = 48
		},
		{
			x = 48*32,
			y = 48*10,
			width = 48*6,
			height = 48
		},
		{
			x = 48*38,
			y = 48*5,
			width = 48,
			height = 48*5
		}
	},
	player = {
		x = 1078, -- in px
		y = 400
		--x = 1678, -- in px
		--y = 300
	},
	cameraPosition = {
		x = 260,
		y = 13
	},
	enemies = {
		{
			id = "green",
			x = 5*48,
			y = 5*48
		}
	},
	objects = {
		-- doors
		{
			id = 1,
			x = 48*15, -- in px
			y = 48*7
		},
		{
			id = 1,
			x = 48*30,
			y = 48*7
		},
		-- left room
		{
			id = 5,
			x = 160,
			y = 48
		},
		{
			id = 6,
			x = 350,
			y = 36
		},
		{
			id = 7,
			x = 540,
			y = 42
		},
		-- center room
		{ -- dragon
			id = 3,
			x = 1054,
			y = 180
		},
		{
			id = 4,
			x = 48*32,
			y = 48*5-10
		},
		{
			id = 9,
			x = 48*32,
			y = 270-10
		},
		{
			id = 8,
			x = 48*33,
			y = 240 - 10
		},
		{
			id = 10,
			x = 48*36,
			y = 190
		},
		{
			id = 11,
			x = 48*37,
			y = 190
		},
		{
			id = 9,
			x = 48*37,
			y = 250
		},
		{
			id = 4,
			x = 48*37,
			y = 275
		},
		{
			id = 12,
			x = 1650,
			y = 250
		},
	}
}

return level_data