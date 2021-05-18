local menu = {}

local menuState = {
    current = 6,
    items = 1,
    stats = 2,
    equipment = 3,
    donate = 4,
    settings = 5,
    chooseMenu = 6
}
local menus = {
    require "scenes/world/menus/items",
    require "scenes/world/menus/stats",
    require "scenes/world/menus/equipment",
    require "scenes/world/menus/donate",
    require "scenes/world/menus/settings",
    require "scenes/world/menus/choose",
}
function menu:load()
    self.font = love.graphics.newFont("asserts/Arial.ttf", love.graphics.getHeight()/24)
    for i = 1, #menus do
        menus[i]:load(self.font)
    end
end

function menu:unload()
    self.font = nil
    for i = 1, #menus do
        menus[i]:unload()
    end
end

function menu:update(delta_time)
    if menus[menuState.current].update then
        menus[menuState.current]:update()
    end
end

function menu:control_button(command, sceneState)
    if command == Command.Deny and menuState.current == menuState.chooseMenu then
        menus[menuState.current].index = 1
        sceneState.current = sceneState.moving
    elseif command == Command.Menu then
        menus[menuState.current].index = 1
        menuState.current = menuState.chooseMenu
        sceneState.current = sceneState.moving
    end
    
    menus[menuState.current]:control_button(command, menuState)
end

function menu:draw()
    menus[menuState.current]:draw()
end

return menu