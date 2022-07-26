local chooseAction = {
	index = 0,
	maxIndex = 5
}

function chooseAction:load()
	local iconsFilenames = {
		"assets/fight/sword.png",
		"assets/fight/shield.png",
		"assets/fight/magic.png",
		"assets/fight/swap-bag.png",
		"assets/fight/run.png"
	}
	self.icons = love.graphics.newArrayImage(iconsFilenames)
end

function chooseAction:control_button(command, scene)
	if command == Command.Left then
		if self.index > 0 then
			self.index = self.index - 1
		end
	elseif command == Command.Right then
		if self.index < self.maxIndex-1 then
			self.index = self.index + 1
		end
	elseif command == Command.Confirm then
		if self.index == 0 then
			events:push({
				type = "target",
				skill = "attack"
			})
		elseif self.index == 1 then
			--scene.characterAnimation:setState("protect")
		elseif self.index == 2 then
			scene.sceneState.current = scene.sceneState.choose
			scene.chooseMenu = love.filesystem.load("scenes/fight/actions/magic.lua")()
		elseif self.index == 3 then
			scene.sceneState.current = scene.sceneState.choose
			scene.chooseMenu = love.filesystem.load("scenes/fight/actions/item.lua")()
		elseif self.index == 4 then
			love.event.quit()
		end
	end
end

function chooseAction:draw(menuHeight)
	local menuItemSize = love.graphics.getHeight() / 7
	local offset = (menuHeight - menuItemSize)/2

	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", offset + self.index *  menuHeight, offset + love.graphics.getHeight() - menuHeight, menuItemSize, menuItemSize, 10, 10)
	love.graphics.setLineWidth(1)

	for i = 1, self.maxIndex do
		love.graphics.drawLayer(self.icons, i, offset + (i - 1) * menuHeight, offset + love.graphics.getHeight() - menuHeight, 0, menuItemSize / self.icons:getWidth())
	end
end

return chooseAction
