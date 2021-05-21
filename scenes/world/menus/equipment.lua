local equipmentMenu = {
    fontHeight = love.graphics.getFont():getHeight(),
    options = character.equipment:getPlaces(),
    index = 1,
    chooseItem = love.filesystem.load("scenes/world/menus/choose_equipment.lua")()
}

function equipmentMenu:unload()
    self.chooseItem = nil
end

function equipmentMenu:control_button(command)
    if self.chooseItem.active then
        self.chooseItem:control_button(command)
        return
    end

    if command == Command.Deny then
        self.isClosed = true
    elseif command == Command.Confirm then
        self.chooseItem.active = true
        self.chooseItem:open(self.options[self.index])
    elseif command == Command.Up then
        if self.index > 1 then
            self.index = self.index - 1
        end
    elseif command == Command.Down then
        if self.index < #self.options then
            self.index = self.index + 1
        end
    end
end

function equipmentMenu:draw()
    if self.chooseItem.active then
        self.chooseItem:draw()
        return
    end

    local offsetX = love.graphics.getWidth()/50
    local cellWidth = love.graphics.getWidth()/3

    love.graphics.printf("Equipment", 0, 20, love.graphics.getWidth(), "center")

    local i = 1
    for place, itemId in pairs(character.equipment:getCurrent()) do
        local offsetY = (i+1)*1.5*self.fontHeight
        love.graphics.print(character:normalizeTitle(place), offsetX, offsetY)

        if itemId > 0 then
            love.graphics.printf(items[itemId].title, cellWidth - offsetX, offsetY, 2*cellWidth, "right")
        else
            love.graphics.printf("nothing", cellWidth - offsetX, offsetY, 2*cellWidth, "right")
        end
        i = i + 1
    end
    
    --local cellHeight = 100
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", offsetX / 2, self.fontHeight + 10 + 1.5*self.fontHeight*(self.index), love.graphics.getWidth() - offsetX, 1.5*self.fontHeight, 10, 10)
    love.graphics.setLineWidth(1)

    local rectangleHeight = love.graphics.getHeight()/10    
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", 0, love.graphics.getHeight() - rectangleHeight, love.graphics.getWidth(), rectangleHeight)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("Confirm - Change item", 0, love.graphics.getHeight() - rectangleHeight/2 - self.fontHeight/2, cellWidth, "center")
    love.graphics.printf("Deny - Go back", 2*cellWidth, love.graphics.getHeight() - rectangleHeight/2 - self.fontHeight/2, cellWidth, "center")
    love.graphics.setColor(1, 1, 1)
end

return equipmentMenu