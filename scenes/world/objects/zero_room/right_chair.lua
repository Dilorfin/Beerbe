local obj = {
	id = 18,
	image = love.graphics.newImage("assets/world/objects/zero_room/right_chair.png"),
	position = {},
	width = 1,
	height = 1,

	physics = {
		size = {
			x = 40,
			y = 60
		},
		offset = {
			x = 26,
			y = 62
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
	love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))

	love.graphics.draw(self.image, self.position.x, self.position.y)
end

return obj