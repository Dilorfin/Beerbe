require "scene_manager"
require "commands"

local mainFont = love.graphics.newFont("asserts/Arial.ttf", 25);
love.graphics.setFont(mainFont)

function love.load()
    --love.mouse.setVisible(false)
    Scene.Load("fight")
    
    character = require "character"
    --character:load()
end

function love.update(dt)
    Scene.update(dt)
end

function love.draw()
    Scene.draw()
end

function love.quit()
    Scene.unload()
    --character:save()
end

function love.lowmemory()
    
end

function love.keypressed(key)
    -- for debug
    if key == "`" then
        love.event.quit()
    end
    if key == "w" or key == "up" then
        Scene.control_axis(0, -1)
        Scene.control_button(Command.Up)
    elseif key == "s" or key == "down" then
        Scene.control_axis(0, 1)
        Scene.control_button(Command.Down)
    elseif key == "a" or key == "left" then
        Scene.control_axis(-1, 0)
        Scene.control_button(Command.Left)
    elseif key == "d" or key == "right" then
        Scene.control_axis(1, 0)
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
        or key == "a" or key == "left"
        or key == "d" or key == "right" 
    then
        Scene.control_axis(0, 0)
    end
end

function love.joystickpressed( joystick, button )
    --print(tostring(button))
    -- for debug
    if button == 7 then
        love.event.quit()
    end
    if button == 8 then
        Scene.control_button(Command.Menu)
    elseif button == 1 then
        Scene.control_button(Command.Confirm)
    elseif button == 2 then
        Scene.control_button(Command.Deny)
    end
end

function love.joystickaxis( joystick, axis, value )
    --print(axis.." : "..value)
    -- x
    if axis == 1 or axis == 4 then
        Scene.control_axis(value, 0)
    -- y
    elseif axis == 2 or axis == 5 then
        Scene.control_axis(0, value)
    end
end

function love.joystickhat( joystick, hat, direction )
    --print(hat.." : "..direction)
    if direction == "d" then
        Scene.control_axis(0, 1)
        Scene.control_button(Command.Down)
    elseif direction == "u" then
        Scene.control_axis(0, -1)
        Scene.control_button(Command.Up)
    elseif direction == "l" then
        Scene.control_axis(-1, 0)
        Scene.control_button(Command.Left)
    elseif direction == "r" then
        Scene.control_axis(1, 0)
        Scene.control_button(Command.Right)
    elseif direction == "c" then
        Scene.control_axis(0, 0)
    end
end
