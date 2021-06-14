require "scenes/world/movables/enemy"
require "scenes/world/movables/hero"

local displaying = require "scenes/world/level_helpers/displaying"
local objectsCollection = require "scenes/world/objects"

local level = {}

function level:load(physicsWorld, camera, levelName)
	local level_data = love.filesystem.load("scenes/world/levels/"..levelName..".lua")()

	self.tiles = level_data.tiles
	self.width = level_data.width
	self.height = level_data.height
	self.possibleEnemies = level_data.possibleEnemies

	if level_data.cameraPosition then
		camera:setPosition(level_data.cameraPosition)
	end
	
	displaying:load(level_data.styleId)

	self.objects = {}
	local initData = {
		world = physicsWorld,
		styleId = level_data.styleId
	}
	for i, data in ipairs(level_data.objects) do
		local obj = objectsCollection:loadObject(data.id, data.x, data.y, initData)
		table.insert(self.objects, obj)
	end

	self.movables = {
		newMovableHero(physicsWorld, level_data.player)
	}
	-- TODO: enemies

	self.walls = {}
	for i, data in ipairs(level_data.walls) do
		local wall = {}
		wall.body = love.physics.newBody(physicsWorld, data.x, data.y, "static")
		wall.shape = love.physics.newRectangleShape(data.width/2, data.height/2, data.width, data.height)
		wall.fixture = love.physics.newFixture(wall.body, wall.shape)

		table.insert(self.walls, wall)
	end
end

function level:unload()
	self.tiles = nil
	self.width = nil
	self.height = nil
	self.possibleEnemies = nil
	self.objects = nil
	self.movables = nil
	-- TODO: enemies
	self.walls = nil
end

function level:update(delta_time)
	for i = 1, #self.objects do
		self.objects[i]:update(delta_time)
	end

	self.movables[1]:update(delta_time)
	local i = 2
	while i <= #self.movables do
		if not self.movables[i].isDestroyed then
			self.movables[i]:update(delta_time)
			i = i + 1
		else
			self.movables[i]:destroy()
			table.remove(self.movables, i)
		end
	end
end

function level:pause()
	for i = 1, #self.movables do
		self.movables[i]:pause()
	end
end

function level:draw(camera)
	displaying:draw(camera, self)

	for i = 1, #self.objects do
		self.objects[i]:draw(camera)
	end
	for i = 1, #self.movables do
		self.movables[i]:draw(camera)
	end
	for i = 1, #self.walls do
		love.graphics.polygon("line", self.walls[i].body:getWorldPoints(self.walls[i].shape:getPoints()))
	end
end

function level:getPlayerMovable()
	return self.movables[1]
end

function level:getAllMovables()
	return self.movables
end

function level:getTile(x, y)
	if not self.tiles or x <= 0 or x > self.width then
		return nil
	end
	return self.tiles[(y-1)*self.width + x]
end

return level