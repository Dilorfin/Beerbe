local enemy_ai = {}
enemy_ai.__index = enemy_ai

local points = {
    { x = 1, y = 2 }, -- top left
    { x = 1, y = 4 }, -- bottom left
    { x = 3, y = 4 }, -- bottom right
    { x = 3, y = 2 }  -- top right
}

enemy_ai.points = {}
for i1, point1 in ipairs(points) do
    for i2, point2 in ipairs(points) do
        table.insert(enemy_ai.points, {point1, point2})
    end
end

function enemy_ai:canSeePlayer(player)
	local distance, x1, y1, x2, y2 = love.physics.getDistance(player.fixture, self.movable.fixture)
	if distance > self.fov then
		return
	end

	local bound1 = { player.fixture:getBoundingBox() }
	local bound2 = { self.movable.fixture:getBoundingBox() }

	local all = 0

	for i, point in ipairs(self.points) do
		local obs = utils.hasObstacles (
			self.movable.body:getWorld(),
			bound1[point[1].x],
			bound1[point[1].y], 
			bound2[point[2].x],
			bound2[point[2].y]
		)
		if obs then
			all = all + 1
		end
	end

	return all < 12
end

function enemy_ai:act(player)
	local see = self:canSeePlayer(player)
	if see then
		self.lastSeen = {
			x = player.body:getX(),
			y = player.body:getY()
		}
	end
	
	if self.lastSeen then
		local v = utils.unitVector(self.lastSeen.x, self.lastSeen.y, self.movable.body:getX(), self.movable.body:getY())
		self.movable:control_axis("x", v.x)
		self.movable:control_axis("y", v.y)

		local dist = utils.distance(self.lastSeen.x, self.lastSeen.y, self.movable.body:getX(), self.movable.body:getY())
		if dist < 10 then
			self.lastSeen = nil
		end
	else
		local random = {
			x = self.movable.body:getX() + love.math.random(-100, 100),
			y = self.movable.body:getY() + love.math.random(-100, 100)
		}
		local v = utils.unitVector(random.x, random.y, self.movable.body:getX(), self.movable.body:getY())

		self.movable:control_axis("x", v.x/2)
		self.movable:control_axis("y", v.y/2)
	end
end

return function(movable)
	local ai = setmetatable({}, enemy_ai)
	
	ai.movable = movable
	ai.fov = 150
	return ai
end