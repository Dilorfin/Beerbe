local chooseAction = {
    index = 0
}

function chooseAction:load()
    local iconsFilenames = {
        "asserts/fight/sword.png",
        "asserts/fight/shield.png",
        "asserts/fight/magic.png",
        "asserts/fight/swap-bag.png",
        "asserts/fight/run.png"
    }
    self.icons = love.graphics.newArrayImage(iconsFilenames)
end

function chooseAction:control_button(command, scene)
    if command == Command.Left then
        if self.index > 0 then
            self.index = self.index - 1
        end
    elseif command == Command.Right then
        if self.index < self.icons:getLayerCount()-1 then
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
            scene.chooseMenu = love.filesystem.load("scenes/fight/choose_magic.lua")()
        elseif self.index == 3 then
            scene.sceneState.current = scene.sceneState.choose
            scene.chooseMenu = love.filesystem.load("scenes/fight/choose_item.lua")()
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

    for i = 1, self.icons:getLayerCount() do
        love.graphics.drawLayer(self.icons, i, offset + (i - 1) * menuHeight, offset + love.graphics.getHeight() - menuHeight, 0, menuItemSize / self.icons:getWidth())
    end
end

return chooseAction