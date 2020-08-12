local menu = {}

character = require "character"
local chooseMenu = require "scenes/world/menus/choose"

local menuState = {
    current = 6,
    items = 1,
    magic = 2,
    equipment = 3,
    donate = 4,
    settings = 5,
    chooseMenu = 6
}

function menu:load()
    self.font = love.graphics.newFont("asserts/Arial.ttf", love.graphics.getHeight()/24)
    chooseMenu:load(self.font)
end

function menu:unload()
    self.font = nil
    chooseMenu:unload()
end

function menu:update(delta_time)
end

function menu:control_button(command)
    if menuState.current == menuState.chooseMenu then
        chooseMenu:control_button(command, menuState)
    end
    
end

function menu:draw()
    if menuState.current == menuState.chooseMenu then
        chooseMenu:draw()
    end
end

return menu