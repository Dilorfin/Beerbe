local menu = {}

character = require "character"

local menuState = {
    current = 6,
    items = 1,
    magic = 2,
    equipment = 3,
    donate = 4,
    settings = 5,
    chooseMenu = 6
}
local menus = {
    -- TODO: remove nil
    require "scenes/world/menus/items",
    nil,
    nil,-- require "scenes/world/menus/equipment" 
    require "scenes/world/menus/donate",
    nil,
    require "scenes/world/menus/choose",
}
function menu:load()
    self.font = love.graphics.newFont("asserts/Arial.ttf", love.graphics.getHeight()/24)
    for i = 1, #menus do
        -- TODO: remove nil check
        if menus[i] then
            menus[i]:load(self.font)
        end
    end
end

function menu:unload()
    self.font = nil
    for i = 1, #menus do
        -- TODO: remove nil check
        if menus[i] then
            menus[i]:unload()
        end
    end
end

function menu:update(delta_time)
end

function menu:control_button(command, sceneState)
    if command == Command.Deny and menuState.current == menuState.chooseMenu then
        chooseMenu.index = 1
        sceneState.current = sceneState.moving
    elseif command == Command.Menu then
        chooseMenu.index = 1
        menuState.current = menuState.chooseMenu
        sceneState.current = sceneState.moving
    end
    
    menus[menuState.current]:control_button(command, menuState)
end

function menu:draw()
    menus[menuState.current]:draw()
end

return menu