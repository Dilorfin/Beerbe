local function createWall(world, x, y, w, h)
	local wall = {}
	wall.body = love.physics.newBody(world, x, y, "static")
	wall.shape = love.physics.newRectangleShape(w/2, h/2, w, h)
	wall.fixture = love.physics.newFixture(wall.body, wall.shape)
	return wall
end

return function(self, world)
	self.movables = {}
	self.objects = {}

	if character.levelId > 0 then
		love.filesystem.load("scenes/world/levels/random_level.lua")()(world, self)
	else
		love.filesystem.load("scenes/world/levels/zero_level.lua")()(world, self)
	end

	self.displaying:load(self.styleId or 1)

	-- spawn objects
	local objInitData = {
		world = world,
		styleId = self.styleId
	}
	for x = 1, self.width do
		for y = 1, self.height do
			local obj = self.objectsMap:getObject(x, y)
			if obj then
				self:setObject(obj, x, y, objInitData)
			end
		end
	end
	
	self.walls = {
		createWall(world, 2*self:getTileSide(), self:getTileSide(), self:getTileSide()*(self.width-1), self:getTileSide()),               -- top
		createWall(world, self:getTileSide(), 2*self:getTileSide(), self:getTileSide(), self:getTileSide()*(self.height-1)),              -- left
		createWall(world, 2*self:getTileSide(), self:getTileSide()*(self.height+1), self:getTileSide()*(self.width-1), self:getTileSide()),-- bottom
		createWall(world, self:getTileSide()*self.width, 2*self:getTileSide(), self:getTileSide(), self:getTileSide()*(self.height-1))     --right
	}

	table.insert(self.movables, 1, newMovableHero(world, {x = self.spawnPosition.x * self:getTileSide(), y = self.spawnPosition.y * self:getTileSide()}))
end