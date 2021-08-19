local obj = {
	id = -7,
	animation = newAnimation(love.graphics.newImage("assets/world/objects/dev_room/chest_dev.png"), 48, 96, 0.1, 3),
	position = {},
	width = 1,
	height = 1,
	isOpened = false,

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
	self.animation:setMode("once")

	self.infoText = "Open dev chest?"
end

function obj:onStartCollide(movable)
	if self.isOpened 
		or not movable.character 
		or movable.character.name ~= "Hero" 
	then
		return nil
	end

	return { 
		type = "show_info",
		text = self.infoText,
		onConfirm = function()
			obj.animation:play()
			obj.isOpened = true
			events:push({
				type = "close_info",
				text = self.infoText
			})
			events:push({
				type = "give_items",
				items = obj.generateContent()
			})
		end
	}
end

function obj:onEndCollide(movable)
	return {
		type = "close_info",
		text = self.infoText
	}
end

function obj.generateContent()
	return { 5, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}
end

function obj:update(dt)
	self.animation:update(dt)
end

function obj:draw()
	love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	self.animation:draw(self.position.x, self.position.y)
end

return obj