local ai = {}

function ai:path_finding()
	-- self.movables[1] - player
	-- self.movables[>1] - enemies
	lines = {}
	
	local bound1 = { self.movables[1].fixture:getBoundingBox() }

	for i = 2, #self.movables do
		local distance, x1, y1, x2, y2 = love.physics.getDistance(self.movables[1].fixture, self.movables[i].fixture)
		if distance <= self.fov then
			
			local bound2 = { self.movables[i].fixture:getBoundingBox() }

			local distances = {}
			local maxId = 0

			local all = 0

			for i, point in ipairs(self.points) do
				table.insert(lines, {bound1[point[1].x], bound1[point[1].y], bound2[point[2].x], bound2[point[2].y]})
				self.world:rayCast(bound1[point[1].x], bound1[point[1].y], bound2[point[2].x], bound2[point[2].y],
					function(fixture, x, y, xn, yn, fraction)
						local ud = fixture:getUserData()
						if ud and ud.character then
							return 1
						end
						all = all + 1
						return 0
					end
				)
			end
			local see = all < 12
			if see then
				local v = { 
					x = x1 - x2,
					y = y1 - y2,
				}
				local m = math.sqrt(v.x^2+v.y^2)
				v.x = v.x / m
				v.y = v.y / m

				self.movables[i]:control_axis("x", v.x)
				self.movables[i]:control_axis("y", v.y)
			end
		end
	end
end
function ai:load(world, map)
	self.world = world
	self.movables = map.movables

	self.fov = 5

	local points = {
		{ x = 1, y = 2 }, -- top left
		{ x = 1, y = 4 }, -- bottom left
		{ x = 3, y = 4 }, -- bottom right
		{ x = 3, y = 2 }  -- top right
	}

	self.points = {}
	for i1, point1 in ipairs(points) do
		for i2, point2 in ipairs(points) do
			table.insert(self.points, {point1, point2})
		end
	end
end

local f = 0
function ai:update(dt)
	f = f + 1
	if f > 15 then
		self:path_finding(self.world, self.movables)
	    f = 0
	end
end

return ai