require "scenes/fight/enemy"
require "scene_manager"
require "commands"
require "animation"

local scene = {}

local menuType = {
    action = 0,
    target = 1,
    magic = 2
}

function scene.load()
    -- load character
    character = require "scenes/fight/character"
    character.animation:load()
    
    -- load targeting
    target = require "scenes/fight/targeting"

    -- load resources
    background = love.graphics.newImage("asserts/fight/background.png")
    
    local iconsFilenames = {
        "asserts/fight/sword.png",
        "asserts/fight/shield.png",
        "asserts/fight/magic.png",
        "asserts/fight/beer-bottle.png",
        "asserts/fight/run.png"
    }
    icons = love.graphics.newArrayImage(iconsFilenames)
    
    -- create enemies
    enemies = {}
    local type = 0
    local number = 3--love.math.random(3)
    for i=1, number do
        table.insert(enemies, newEnemy(2, i))
    end
    
    -- init variables
    choose = 0
    menu = menuType.action
end

function scene.unload()
    character.animation:unload()
    background = nil
    icons = nil
    enemies = nil
    target = nil
end

function scene.update(delta_time)
    character.animation:update(delta_time)
end

function scene.control_button(command)
    if menu == menuType.action then
        if command == Command.Left then
            if choose > 0 then
                choose = choose - 1
            end
        elseif command == Command.Right then
            if choose < icons:getLayerCount()-1 then
                choose = choose + 1
            end
        elseif command == Command.Confirm then
            if choose == 0 then
                menu = menuType.target
                target.type = "attack"
            elseif choose == 1 then
                character.animation:setState("protect")
            elseif choose == 2 then
                character.animation:setState("cast")
            elseif choose == 4 then
                love.event.quit()
            end
        elseif command == Command.Deny then
            character.animation:setState("stand")
        end
    elseif menu == menuType.target then
        if command == Command.Left then
            target:left()
        elseif command == Command.Right then
            target:right()
        elseif command == Command.Confirm then
            character.animation:setState("attack")
        elseif command == Command.Deny then
            menu = menuType.action
        end
    end
end

function scene.draw()
    local menuHeight = love.graphics.getHeight() / 6
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), (love.graphics.getHeight() - menuHeight) / background:getHeight())

    
    for i = 1, #enemies do
        enemies[i]:draw()
    end

    character.animation:draw()

    

    if menu == menuType.action then
        
        local menuItemSize = love.graphics.getHeight() / 7
        local offset = (menuHeight - menuItemSize)/2

        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", offset + choose *  menuHeight, offset + love.graphics.getHeight() - menuHeight, menuItemSize, menuItemSize, 10, 10)
        love.graphics.setLineWidth(1)

        for i = 1, icons:getLayerCount() do
            love.graphics.drawLayer(icons, i, offset + (i - 1) * menuHeight, offset + love.graphics.getHeight() - menuHeight, 0, menuItemSize / icons:getWidth())
        end

    elseif menu == menuType.target then
        target:draw()
    end
    

end

function scene.control_axis(x_axis, y_axis)
end

return scene
