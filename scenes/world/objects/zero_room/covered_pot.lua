local obj = {
	id = 15,
	image = love.graphics.newImage("assets/world/objects/zero_room/covered_pot.png"),
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
	local tileSide = 48

	self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
	self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
end

function obj:onStartCollide(moving)
end

function obj:update(dt)
end

function obj:draw(camera)
	love.graphics.draw(self.image, self.position.x, self.position.y)
end

return obj