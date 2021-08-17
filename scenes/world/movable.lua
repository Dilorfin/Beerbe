local movingCharacter = {
	states = {
		upward = 1,
		downward = 2,
		leftward = 3,
		rightward = 4
	}
}

movingCharacter.__index = movingCharacter

function movingCharacter:isMoving()
	return (math.abs(self.speed.x) + math.abs(self.speed.y)) ~= 0
end

function movingCharacter:destroy()
	self.body:destroy()
end

function movingCharacter:update(delta_time)
	local x = 100 * self.speed.x * delta_time + self.body:getX()
	local y = 100 * self.speed.y * delta_time + self.body:getY()

	self.body:setPosition(x, y)

	self.animationSet:update(delta_time)
end

function movingCharacter:pause()
	self.speed.x = 0
	self.speed.y = 0
	self.animationSet:stop()
end

function movingCharacter:getSize()
	return self.animationSet:getSize()
end

function movingCharacter:getPosition()
	return {x = self.body:getX(), y = self.body:getY()}
end

function movingCharacter:control_axis(axis, value)
	if (math.abs(value) < 0.24 and value ~= 0) then
		return
	end

	self.speed[axis] = value
	
	self.animationSet:play()
	if math.abs(self.speed.x) > math.abs(self.speed.y) then
		if self.speed.x < 0 then
			self.animationSet:setState(self.states.leftward)
		elseif self.speed.x > 0 then
			self.animationSet:setState(self.states.rightward)
		end
	elseif self.speed.x == self.speed.y and self.speed.y == 0 then
		self.animationSet:stop()
	else
		if self.speed.y < 0 then
			self.animationSet:setState(self.states.upward)
		elseif self.speed.y > 0 then
			self.animationSet:setState(self.states.downward)
		end
	end
end

function movingCharacter:draw(camera)
	love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	self.animationSet:draw(self.body:getX(),  self.body:getY())
end

function newMovable(world, position, animationSet, tag)
	local movable = {}

	movable.tag = tag
	movable.isDestroyed = false
	movable.character = character
	movable.animationSet = animationSet
	movable.speed = {
		x = 0,
		y = 0
	}

	local animX, animY = animationSet:getSize()

	movable.body = love.physics.newBody(world, position.x, position.y, "dynamic")
	movable.body:setFixedRotation(true)
	movable.body:setSleepingAllowed(false)
	movable.shape = love.physics.newRectangleShape(animX/2, animY/2, animX, animY)
	movable.fixture = love.physics.newFixture(movable.body, movable.shape)
	movable.fixture:setUserData(movable)

	return setmetatable(movable, movingCharacter)
end