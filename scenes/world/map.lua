local objectsCollection = require "scenes/world/objects"

local map = {}

map.objectsMap = {
	map = {},
	setObject = function(self, id, x, y)
		self.map[(y-1)*map.width + x] = id
	end,
	getObject = function(self, x, y)
		return self.map[(y-1)*map.width + x]
	end
}

map.load = require "scenes/world/level_helpers/loader"
map.displaying = require "scenes/world/level_helpers/displaying"

function map:pause()
	for i = 1, #self.movables do
		self.movables[i]:pause()
	end
end

function map:unload()
	self.objects = {}
	self.map = {}
	self.movables = {}
	self.objectsMap.map = {}
end

function map:getCell(x, y)
	if not self.map or x <= 0 or x > self.width then
		return nil
	end
	return self.map[(y-1)*self.width + x]
end

function map:setObject(id, x, y, initData)
	local obj = objectsCollection:loadObject(id, x*self:getTileSide(), y*self:getTileSide(), initData)

	table.insert(self.objects, obj)
end

function map:getTileSide()
	return 48
end

function map:update(dt)
	for i = 1, #self.objects do
		self.objects[i]:update(dt)
	end

	self.movables[1]:update(dt)
	local i = 2
	while i <= #self.movables do
		if not self.movables[i].isDestroyed then
			self.movables[i]:update(dt)
			i = i + 1
		else
			self.movables[i]:destroy()
			table.remove(self.movables, i)
		end
	end
end

function map:draw(camera)
	local tileSide = self:getTileSide()

	self.displaying:draw(camera, self)

	for i = 1, #self.objects do
		self.objects[i]:draw()
	end
	for i = 1, #self.walls do
		love.graphics.polygon("line", self.walls[i].body:getWorldPoints(self.walls[i].shape:getPoints()))
	end
	for i = 1, #self.movables do
		self.movables[i]:draw(camera)
	end
end

return map