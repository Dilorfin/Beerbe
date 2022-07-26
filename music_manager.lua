local musicManager = {
	sources = {
		main = love.audio.newSource("asserts/music/main.wav", "stream"),
		fight = love.audio.newSource("asserts/music/battle.wav", "stream")
	},
	current = nil,
	next = nil
}
for title, source in pairs(musicManager.sources) do
	source:setLooping(true)
end

function musicManager:playNext(title)
	if not self.current then
		self.current = title
		self.sources[self.current]:setVolume(1)
		self.sources[self.current]:play()
	elseif self.current ~= title then
		self.next = title
		self.sources[self.next]:play()
		self.sources[self.next]:setVolume(0)
	end
end

function musicManager:update(dt)
	if self.next then
		if self.sources[self.current]:getVolume() <= 0.001 then
			self.sources[self.current]:stop()
			
			self.sources[self.next]:setVolume(1)
			self.current = self.next
			self.next = nil
		else
			local coefficient = 0.5
			self.sources[self.current]:setVolume(self.sources[self.current]:getVolume() - dt*coefficient)
		end
	end
end

return musicManager
