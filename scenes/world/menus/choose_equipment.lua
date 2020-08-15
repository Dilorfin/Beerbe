local chooseItem = {}

character = require "character"
require "items"

function chooseItem:load(font)
    self.font = font
end

local function filter(type, equipped)
    equipped = equipped or 0
    filteredItems = { 0 }
    for i = 1, equipped - 1 do
        if items[character.bag[i]].type == type then
            table.insert(filteredItems, i)
        end
    end
    for i = equipped + 1, #character.bag do
        if items[character.bag[i]].type == type then
            table.insert(filteredItems, i)
        end
    end
    return filteredItems
end

function chooseItem:open(place)
    self.place = place
    self.index = 1

    local secondHand = self.place
    if self.place == "right_hand" then
        secondHand = "left_hand"
    elseif self.place == "left_hand" then
        secondHand = "right_hand"
    end
    self.filteredItems = filter("sword", character.equipped[secondHand])
end

function chooseItem:unload()
    self.filteredItems = nil
end

function chooseItem:control_button(command, itemChooseMenu)
    if command == Command.Confirm then
        if #self.filteredItems < 1 or not self.place then
            return
        end

        local bagId = self.filteredItems[self.index]
        if bagId == 0 then
            character.equipped[self.place] = nil
        else
            character.equipped[self.place] = bagId
        end
        itemChooseMenu.active = false
        self.index = 1
    elseif command == Command.Up then
        if self.index > 3 then 
            self.index = self.index - 3
        end
    elseif command == Command.Down then
        if self.index < #self.filteredItems - 2 then 
            self.index = self.index + 3
        end
    elseif command == Command.Left then
        if self.index > 1 then 
            self.index = self.index - 1
        end
    elseif command == Command.Right then
        if self.index < #self.filteredItems then 
            self.index = self.index + 1
        end
    end
end

function chooseItem:draw()
    love.graphics.printf("Items menu", self.font, 0, 20, love.graphics.getWidth(), "center")

    local cellWidth = love.graphics.getWidth()/3
    local cellHeight = 100
    
    -- items grid
    for i, bagId in pairs(self.filteredItems) do
        local posX = cellWidth*((i-1)%3)
        local posY = cellHeight*math.ceil(i/3)
        local title = "nothing"
        if bagId ~= 0 then
            title = items[character.bag[bagId]].title
        end
        love.graphics.printf(title, self.font, posX, posY, cellWidth, "center")
    end

    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", 10 + cellWidth * ((self.index-1) % 3 ), cellHeight*(math.ceil(self.index/3))-20, cellWidth - 20, 90, 10, 10)
    love.graphics.setLineWidth(1)
    
    -- bottom info
    local rectangleHeight = love.graphics.getHeight()/10    
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", 0, love.graphics.getHeight() - rectangleHeight, love.graphics.getWidth(), rectangleHeight)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("Confirm - Use item", self.font, 0, love.graphics.getHeight() - rectangleHeight/2 - self.font:getHeight()/2, cellWidth, "center")
    love.graphics.printf("Deny - Go back", self.font, 2*cellWidth, love.graphics.getHeight() - rectangleHeight/2 - self.font:getHeight()/2, cellWidth, "center")
    love.graphics.setColor(1, 1, 1)
end

return chooseItem