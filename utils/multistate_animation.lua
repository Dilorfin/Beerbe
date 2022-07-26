require "utils/animation"

local ms_animation  = {}
ms_animation.__index = ms_animation

function ms_animation:unload()
	--TODO: smth is going wrong on fight start
	--self.animation = nil
end

function ms_animation:getSize()
	return self.animation:getSize()
end

function ms_animation:play()
	self.animation:play()
end
function ms_animation:stop()
	self.animation:stop()
end

function ms_animation:setState(st)
	if type(st) == "string" and self.mp_table then
		if type(self.mp_table[st]) ~= "number" then
			error("Animation states should be maped to numbers")
		end
		self.state = self.mp_table[st]
	elseif type(st) == "number" then
		self.state = st
	else
		error("Unnown state: "..st)
	end
end

function ms_animation:update(dt)
	self.animation:update(dt)
end

function ms_animation:draw(x, y, scale)
	--TODO: deal with scale??
	self.animation:drawLayer(self.state, x, y, 0, scale)
end

function newMultistateAnimation(im_files, f_width, f_height, delay, f_number, animation_type)
	local anim = {}

	anim.animation = newAnimation(
		love.graphics.newArrayImage(im_files), 
		f_width, f_height, delay, f_number
	)

	anim.state = 1
	anim.animation:setMode(animation_type)
	anim.animation:stop()
	
	return setmetatable(anim, ms_animation)
end
