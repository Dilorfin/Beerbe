local equipmentMenu = {}

character = require "character"
require "items"

function equipmentMenu:load(font)
    self.font = font
    self.options = {
        "right_hand",
        "left_hand"
    }
    self.index = 1
    self.chooseItem = {
        menu = love.filesystem.load("scenes/world/menus/choose_equipment.lua")(),
        active = false
    }
    self.chooseItem.menu:load(font)
end

function equipmentMenu:unload()
    self.chooseItem.menu:unload()
    self.choose = nil
end

function equipmentMenu:control_button(command, menuState)
    if self.chooseItem.active then
        if command == Command.Deny then
            self.chooseItem.active = false
        else
            self.chooseItem.menu:control_button(command, self.chooseItem)
        end
        return
    end

    if command == Command.Deny then
        menuState.current = menuState.chooseMenu
    elseif command == Command.Confirm then
        self.chooseItem.active = true
        self.chooseItem.menu:open(self.options[self.index])
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
        self.chooseItem.menu:draw()
        return
    end

    local offsetX = love.graphics.getWidth()/50
    local cellWidth = love.graphics.getWidth()/3

    love.graphics.printf("Equipment", self.font, 0, 20, love.graphics.getWidth(), "center")

    for i = 1, #self.options do 
        local offsetY = (i+1)*1.5*self.font:getHeight()
        
        -- format for displaying "right_hand" -> "Right hand"
        local title = self.options[i]:gsub("_", " "):gsub("^%l", string.upper)
        love.graphics.print(title, self.font, offsetX, offsetY)
        
        local bagId = character.equipped[self.options[i]]
        if bagId then
            local itemId = character.bag[character.equipped[self.options[i]]]
            love.graphics.printf(items[itemId].title, self.font, cellWidth - offsetX, offsetY, 2*cellWidth, "right")
        else
            love.graphics.printf("nothing", self.font, cellWidth - offsetX, offsetY, 2*cellWidth, "right")
        end
    end
    
    --local cellHeight = 100
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", offsetX / 2, self.font:getHeight() + 10 + 1.5*self.font:getHeight()*(self.index), love.graphics.getWidth() - offsetX, 1.5*self.font:getHeight(), 10, 10)
    love.graphics.setLineWidth(1)

    local rectangleHeight = love.graphics.getHeight()/10    
    love.graphics.setColor(1, 1, 1, 0.7)
    love.graphics.rectangle("fill", 0, love.graphics.getHeight() - rectangleHeight, love.graphics.getWidth(), rectangleHeight)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("Confirm - Change item", self.font, 0, love.graphics.getHeight() - rectangleHeight/2 - self.font:getHeight()/2, cellWidth, "center")
    love.graphics.printf("Deny - Go back", self.font, 2*cellWidth, love.graphics.getHeight() - rectangleHeight/2 - self.font:getHeight()/2, cellWidth, "center")
    love.graphics.setColor(1, 1, 1)
end

return equipmentMenu