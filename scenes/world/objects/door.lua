local obj = {
	id = 1,
	animation = newAnimation(love.graphics.newImage("assets/world/objects/door.png"), 48, 48, 0.1, 3),
	position = {},
	width = 1,
	height = 1,

	physics = {
		size = {
			x = 48,
			y = 48
		},
		offset = {
			x = 24,
			y = 24
		}
	}
}

function obj:init(initData)
	self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
	self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)

	self.animation:stop()
	self.timer = newTimer(0.3)
end

function obj:onStartCollide(movable)
	if not movable.character 
		or movable.character.name ~= "Hero"
	then
		return nil
	end
	self.animation:play()
end

function obj:update(dt)
	if self.animation and self.animation.playing then
		self.animation:update(dt)
		self.timer:update(dt)

		if self.timer:isTime() then
			self.animation:stop()
			self.fixture:destroy()
			self.animation = nil
		end
	end
end

function obj:draw(camera)
	if self.animation then
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
		self.animation:draw(self.position.x, self.position.y)
	end
end

return obj