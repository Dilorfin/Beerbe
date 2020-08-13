local menu = {}

character = require "character"
local chooseMenu = require "scenes/world/menus/choose"
local items = require "scenes/world/menus/items"
local donate = require "scenes/world/menus/donate"

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
    items:load(self.font)
    donate:load(self.font)
end

function menu:unload()
    self.font = nil
    chooseMenu:unload()
    items:unload()
    donate:unload()
end

function menu:update(delta_time)
end

function menu:control_button(command, sceneState)
    if command == Command.Deny then
        if menuState.current == menuState.chooseMenu then
            chooseMenu.index = 1
            sceneState.current = sceneState.moving
        else
            menuState.current = menuState.chooseMenu
        end
    elseif command == Command.Menu then
        chooseMenu.index = 1
        menuState.current = menuState.chooseMenu
        sceneState.current = sceneState.moving
    end

    if menuState.current == menuState.chooseMenu then
        chooseMenu:control_button(command, menuState)
    elseif menuState.current == menuState.items then
        items:control_button(command)
    elseif menuState.current == menuState.donate then
        donate:control_button(command)
    end
end

function menu:draw()
    if menuState.current == menuState.chooseMenu then
        chooseMenu:draw()
    elseif menuState.current == menuState.items then
        items:draw()
    elseif menuState.current == menuState.donate then
        donate:draw()
    end
end

return menu