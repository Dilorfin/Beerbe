require "scene_manager"
require "commands"

local scene = {}

local menuType = {
    Action = 0,
    Target = 1,
    Magic = 2
}

function scene.load ()
    -- load resources
    local prefix = "asserts/fight/"
    background = love.graphics.newImage(prefix.."background.png")
    local iconsNames = {
        prefix.."sword.png",
        prefix.."shield.png",
        prefix.."magic.png",
        prefix.."beer-bottle.png",
        prefix.."run.png"
    }
    icons = love.graphics.newArrayImage(iconsNames)

    -- init variables
    choose = 0
    menu = menuType.Action
end

function scene.unload()
    background = nil
    icons = nil
end

function scene.update(delta_time)
    
end

function scene.control_button(command)
    if menu == menuType.Action then
        if command == Command.Left then
            if choose > 0 then
                choose = choose - 1
            end
        elseif command == Command.Right then
            if choose < icons:getLayerCount()-1 then
                choose = choose + 1
            end
        elseif command == Command.Confirm then
            print "confirm"
        elseif command == Command.Deny then
            print "deny"
        end
    end
end

function scene.control_axis(x_axis, y_axis)
    
end

function scene.draw()
    if menu == menuType.Action then
        local menuHeight = love.graphics.getHeight() / 6
        local menuItemSize = love.graphics.getHeight() / 7
        local offset = (menuHeight - menuItemSize)/2
        
        love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), (love.graphics.getHeight() - menuHeight) / background:getHeight())

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, love.graphics.getHeight() - menuHeight, love.graphics.getWidth(), menuHeight)
        love.graphics.setColor(1, 1, 1)
        
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", offset + choose *  menuHeight, offset + love.graphics.getHeight() - menuHeight, menuItemSize, menuItemSize, 10, 10)
        love.graphics.setLineWidth(1)

        for i = 1, icons:getLayerCount() do
            love.graphics.drawLayer(icons, i, offset + (i - 1) * menuHeight, offset + love.graphics.getHeight() - menuHeight, 0, menuItemSize / icons:getWidth())
        end
    end
end

return scene