local chooseItem = {}
chooseItem.index = 1
chooseItem.items = character.inventory:getUsableItems()

local fontHeight = love.graphics.getFont():getHeight()

function chooseItem:control_button(command, sceneState)
    if command == Command.Confirm then
        if #self.items <= 0 then
            return
        end
        
        local item = items[self.items[self.index]]
        if item.use then
            item:use(character)
            character.inventory:removeItem(item.id)
            table.remove(self.items, self.index)
        end
    elseif command == Command.Deny then
        sceneState.current = sceneState.action
    elseif command == Command.Up then
        if self.index > 3 then 
            self.index = self.index - 3
        end
    elseif command == Command.Down then
        if self.index < #self.items - 2 then 
            self.index = self.index + 3
        end
    elseif command == Command.Left then
        if self.index > 1 then 
            self.index = self.index - 1
        end
    elseif command == Command.Right then
        if self.index < #self.items then 
            self.index = self.index + 1
        end
    end
end

function chooseItem:draw()
    love.graphics.printf("Items menu", 0, 20, love.graphics.getWidth(), "center")

    local cellWidth = love.graphics.getWidth()/3
    local cellHeight = 100
    
    if #self.items <= 0 then
        love.graphics.printf("Nothing's here xD", 0, love.graphics.getHeight()/2-fontHeight, love.graphics.getWidth(), "center")
    else
        for i, itemId in pairs(self.items) do
            local posX = cellWidth*((i-1)%3)
            local posY = cellHeight*math.ceil(i/3)

            love.graphics.printf(items[itemId].title, posX, posY, cellWidth, "center")
        end

        love.graphics.setLineWidth(4)
        love.graphics.rectangle("line", 10 + cellWidth * ((self.index-1) % 3 ), cellHeight*(math.ceil(self.index/3))-20, cellWidth - 20, 90, 10, 10)
        love.graphics.setLineWidth(1)
    end
end

return chooseItem