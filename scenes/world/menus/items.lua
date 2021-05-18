local itemsMenu = {
    index = 1
}

function itemsMenu:filter()    
    self.usableItems = character.inventory:getUsableItems()
end

function itemsMenu:load(font)
    self.font = font
    self:filter()
end

function itemsMenu:unload()
    self.usableItems = nil
end

function itemsMenu:update(delta_time)
    -- TODO: remove this crutch...
    self:filter()
end

function itemsMenu:control_button(command, menuState)
    if command == Command.Deny then
        menuState.current = menuState.chooseMenu
    elseif command == Command.Confirm then
        if #self.usableItems < 1 then
            return
        end

        local item = items[self.usableItems[self.index]]
        item:use(character)
        table.remove(self.usableItems, self.index)
        character.inventory:removeItem(item.id)

        if self.index > #self.usableItems then
            self.index = #self.usableItems
        end
    elseif command == Command.Up then
        if self.index > 3 then 
            self.index = self.index - 3
        end
    elseif command == Command.Down then
        if self.index < #self.usableItems - 2 then 
            self.index = self.index + 3
        end
    elseif command == Command.Left then
        if self.index > 1 then 
            self.index = self.index - 1
        end
    elseif command == Command.Right then
        if self.index < #self.usableItems then 
            self.index = self.index + 1
        end
    end
end

function itemsMenu:draw()
    love.graphics.printf("Items menu", self.font, 0, 20, love.graphics.getWidth(), "center")

    local cellWidth = love.graphics.getWidth()/3
    local cellHeight = 100
    
    if #self.usableItems <= 0 then
        love.graphics.printf("Nothing's here ", self.font, 0, love.graphics.getHeight()/2-self.font:getHeight(), love.graphics.getWidth(), "center")
    else
        for i, itemId in pairs(self.usableItems) do
            local posX = cellWidth*((i-1)%3)
            local posY = cellHeight*math.ceil(i/3)

            love.graphics.printf(items[itemId].title, self.font, posX, posY, cellWidth, "center")
        end

        love.graphics.setLineWidth(4)
        love.graphics.rectangle("line", 10 + cellWidth * ((self.index-1) % 3 ), cellHeight*(math.ceil(self.index/3))-20, cellWidth - 20, 90, 10, 10)
        love.graphics.setLineWidth(1)
    end
    
    local rectangleHeight = love.graphics.getHeight()/10    
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", 0, love.graphics.getHeight() - rectangleHeight, love.graphics.getWidth(), rectangleHeight)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("Confirm - Use item", self.font, 0, love.graphics.getHeight() - rectangleHeight/2 - self.font:getHeight()/2, cellWidth, "center")
    love.graphics.printf("Deny - Go back", self.font, 2*cellWidth, love.graphics.getHeight() - rectangleHeight/2 - self.font:getHeight()/2, cellWidth, "center")
    love.graphics.setColor(1, 1, 1)
end

return itemsMenu