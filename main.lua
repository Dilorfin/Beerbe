require "utils/scene_manager"
require "utils/timer"
require "utils/utils"
require "character/items"
require "commands"

local mainFont = love.graphics.newFont("assets/Arial.ttf", 25);
love.graphics.setFont(mainFont)

character = require "character"
events = require "utils/event_queue"

function love.load()
    Scene.Load("world")
end

function love.update(dt)
    Scene.update(dt)
end

function love.draw()
    Scene.draw()
end

function love.quit()
    Scene.unload()
end

function love.keypressed(key)
    if key == "w" or key == "up" then
        Scene.control_axis("y", -1)
        Scene.control_button(Command.Up)
    elseif key == "s" or key == "down" then
        Scene.control_axis("y", 1)
        Scene.control_button(Command.Down)
    elseif key == "a" or key == "left" then
        Scene.control_axis("x", -1)
        Scene.control_button(Command.Left)
    elseif key == "d" or key == "right" then
        Scene.control_axis("x", 1)
        Scene.control_button(Command.Right)
    elseif key == "escape" then
        Scene.control_button(Command.Menu)
    elseif key == "return" then
        Scene.control_button(Command.Confirm)
    elseif key == "backspace" then
        Scene.control_button(Command.Deny)
    end
end

function love.keyreleased(key)
    if key == "w" or key == "up" 
       or key == "s" or key == "down"
    then
        Scene.control_axis("y", 0)
    elseif key == "a" or key == "left" 
        or key == "d" or key == "right"
    then
        Scene.control_axis("x", 0)
    end
end

function love.gamepadreleased( joystick, button )
    -- for debug
    if button == "back" then
        love.event.quit()
    end
    
    if button == "start" then
        Scene.control_button(Command.Menu)
    elseif button == "a" then
        Scene.control_button(Command.Confirm)
    elseif button == "b" then
        Scene.control_button(Command.Deny)
    elseif button == "dpup" then
        Scene.control_button(Command.Up)
    elseif button == "dpdown" then
        Scene.control_button(Command.Down)
    elseif button == "dpleft" then
        Scene.control_button(Command.Left)
    elseif button == "dpright" then
        Scene.control_button(Command.Right)
    end
end

function love.gamepadaxis(joystick, axis, value)
    local axis = string.sub(axis,#axis,#axis)    
    --print(axis.." : "..value)
    Scene.control_axis(axis, value)
    if value == -1 then
        if axis == "x" then
            Scene.control_button(Command.Left)
        elseif axis == "y" then
            Scene.control_button(Command.Up) 
        end
    elseif value == 1 then
        if axis == "x" then
            Scene.control_button(Command.Right) 
        elseif axis == "y" then
            Scene.control_button(Command.Down) 
        end
    end
end
