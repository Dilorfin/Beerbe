require "scene_manager"
require "commands"
require "animation"

local scene = {}

local menuType = {
    Action = 0,
    Target = 1,
    Magic = 2
}

local heroStateTypes = {
    Stand = 1,
    Attack = 2,
    Protect = 3,
    Cast = 4,
    Die = 5,
}

function scene.load ()
    -- load resources
    local prefix = "asserts/fight/"
    background = love.graphics.newImage(prefix.."background.png")

    local iconsFilenames = {
        prefix.."sword.png",
        prefix.."shield.png",
        prefix.."magic.png",
        prefix.."beer-bottle.png",
        prefix.."run.png"
    }
    icons = love.graphics.newArrayImage(iconsFilenames)

    local heroFilenames = {
        prefix.."animations/stand.png",
        prefix.."animations/attack.png",
        prefix.."animations/protect.png",
        prefix.."animations/cast.png",
        prefix.."animations/death.png"
    }
    local heroSourceImage = love.graphics.newArrayImage(heroFilenames)
    hero = newAnimation(heroSourceImage, 64, 64, 0.11, 3)

    -- init variables
    choose = 0
    menu = menuType.Action
    heroState = heroStateTypes.Stand
end

function scene.unload()
    hero = nil
    background = nil
    icons = nil
end

function scene.update(delta_time)
    hero:update(delta_time)
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

        -- heroState
        hero:drawLayer(choose+1, 600, 250, 0, 1, 1) -- add scaling...
    end
end

return scene