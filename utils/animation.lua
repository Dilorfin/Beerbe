--[[ Copyright (c) 2009 Bart Bes ]]

local anim_mt = {}
anim_mt.__index = anim_mt

function newAnimation(image, fw, fh, delay, frames_number)
	local a = {}
	a.img = image
	a.frames = {}
	a.delays = {}
	a.timer = 0
	a.position = 1
	a.fw = fw
	a.fh = fh
	a.playing = true
	a.speed = 1
	a.mode = 1 -- default - "loop"
	a.direction = 1
	local imgw = image:getWidth()
	local imgh = image:getHeight()
	if frames_number == 0 then
		frames_number = imgw / fw * imgh / fh
	end
	local rowsize = imgw/fw
	for i = 0, frames_number-1 do
		local row = math.floor(i/rowsize)
		local column = i%rowsize
		local frame = love.graphics.newQuad(column*fw, row*fh, fw, fh, imgw, imgh)
		table.insert(a.frames, frame)
		table.insert(a.delays, delay)
	end
	return setmetatable(a, anim_mt)
end

function anim_mt:update(dt)
	if not self.playing then return end
	self.timer = self.timer + dt * self.speed
	if self.timer > self.delays[self.position] then
		self.timer = self.timer - self.delays[self.position]
		self.position = self.position + 1 * self.direction
		if self.position > #self.frames then
			if self.mode == 1 then -- loop
				self.position = 1
			elseif self.mode == 2 then -- once
				self.position = self.position - 1
				self:stop()
			elseif self.mode == 3 then -- bounce
				self.direction = -1
				self.position = self.position - 1
			end
		elseif self.position < 1 and self.mode == 3 then -- bounce
			self.direction = 1
			self.position = self.position + 1
		end
	end
end

function anim_mt:draw(x, y, angle, sx, sy)
	love.graphics.draw(self.img, self.frames[self.position], x, y, angle, sx, sy)
end

function anim_mt:drawLayer(layer, x, y, angle, sx, sy)
	love.graphics.drawLayer(self.img, layer, self.frames[self.position], x, y, angle, sx, sy)
end

function anim_mt:addFrame(x, y, w, h, delay)
	local frame = love.graphics.newQuad(x, y, w, h, a.img:getWidth(), a.img:getHeight())
	table.insert(self.frames, frame)
	table.insert(self.delays, delay)
end

function anim_mt:play()
	self.playing = true
end

function anim_mt:stop()
	self.playing = false
end

function anim_mt:reset()
	self:seek(1)
end

function anim_mt:seek(frame)
	self.position = frame
	self.timer = 0
end

function anim_mt:getCurrentFrame()
	return self.position
end

function anim_mt:getFramesNumber()
	return #self.frames
end

function anim_mt:setDelay(frame, delay)
	self.delays[frame] = delay
end

function anim_mt:setSpeed(speed)
	self.speed = speed
end

function anim_mt:getSize()
    return self.fw, self.fh
end

function anim_mt:getWidth()
	return self.fw
end

function anim_mt:getHeight()
	return self.fh
end

function anim_mt:setMode(mode)
	if mode == "loop" then
		self.mode = 1
	elseif mode == "once" then
		self.mode = 2
	elseif mode == "bounce" then
		self.mode = 3
	end
end
