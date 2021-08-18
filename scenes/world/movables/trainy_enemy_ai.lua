local enemy_ai = {}
enemy_ai.__index = enemy_ai

function enemy_ai:act(player)
	local random = {
		x = self.movable.body:getX() + love.math.random(-100, 100),
		y = self.movable.body:getY() + love.math.random(-100, 100)
	}
	local v = utils.unitVector(random.x, random.y, self.movable.body:getX(), self.movable.body:getY())

	self.movable:control_axis("x", v.x/3)
	self.movable:control_axis("y", v.y/3)
end

return function(movable)
	local ai = setmetatable({}, enemy_ai)
	
	ai.movable = movable
	ai.fov = 90
	return ai
end