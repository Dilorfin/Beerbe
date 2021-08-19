local obj = {
	id = 3,
	image = love.graphics.newImage("assets/world/objects/zero_room/dragon.png"),
	position = {},
	width = 2,
	height = 2,

	physics = {
		size = {
			x = 96,
			y = 96
		},
		offset = {
			x = 48,
			y = 48
		}
	}
}

function obj:init(initData)
	self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
	self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
	
	self.infoText = "Go to ...?"
end

function obj:onStartCollide(movable)
	return { 
		type = "show_info",
		text = self.infoText,
		onConfirm = function()
			events:push("next_level")
		end
	}
end

function obj:onEndCollide(movable)
	return {
		type = "close_info",
		text = self.infoText
	}
end

function obj:update(dt)
end

function obj:draw()
	love.graphics.draw(self.image, self.position.x, self.position.y)
end

return obj