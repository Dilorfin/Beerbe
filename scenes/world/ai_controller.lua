local ai_controller = {}

function ai_controller:load(world, movables)
	self.world = world
	self.movables = movables
	self.player = movables[1]

	self.frequency = 15
	self.counter = 0
end

function ai_controller:update(dt)
	self.counter = self.counter + 1
	if self.counter > self.frequency then
	    self.counter = 0
		for i = 1, #self.movables do
			if self.movables[i].ai then
				self.movables[i].ai:act(self.player)
			end
		end
	end
end

return ai_controller