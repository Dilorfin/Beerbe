require "items"

local chooseItem = {}
chooseItem.index = 1
chooseItem.items = {}

local fontHeight = love.graphics.getFont():getHeight()
local character = require "character"

for i, itemId in pairs(character.bag) do
    if items[itemId].type == "potion" then
        table.insert(chooseItem.items, itemId)
    end
end
table.sort(chooseItem.items)

function chooseItem:control_button(command, sceneState)
    if command == Command.Confirm then
        if #self.items <= 0 then
            return
        end
        
        sceneState.current = sceneState.effect
        local item = items[self.items[self.index]]
        if item.type == "potion" then
            if item.health ~= nil then
                character.health = character.health + item.health
                if character.health > character:getMaxHealth() then
                    character.health = character:getMaxHealth()
                end
            end
            if item.mana ~= nil then
                character.mana = character.mana + item.mana
                if character.mana > character:getMaxMana() then
                    character.mana = character:getMaxMana()
                end
            end
        end

        table.remove(self.items, self.index)
        for i = 1, #character.bag do
            if character.bag[i] == item.id then
                table.remove(character.bag, i)
                return
            end
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