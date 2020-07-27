require "scene_manager"
require "commands"

local scene = {}

function scene.load ()
    local bigFont = love.graphics.newFont("asserts/Arial.ttf", 50)
    wastedText = love.graphics.newText(bigFont, "WASTED")
    local width, height = wastedText:getDimensions()
    wastedTransform = love.math.newTransform(love.graphics.getWidth()/2 - width/2, love.graphics.getHeight()/2 - height)
end

function scene.unload()
    
end

function scene.update(delta_time)
    
end

function scene.control_button(command)
    if command == Command.Confirm then
        print "confirm"
    elseif command == Command.Deny then
        print "deny"
    end
end

function scene.control_axis(x_axis, y_axis)
    
end

function scene.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(wastedText, wastedTransform)
end

return scene