require "scene_manager"
require "commands"

function love.load()
    love.mouse.setVisible(false)
    Scene.Load("test")
end

function love.draw()
    Scene.draw()
end

function love.keypressed(key)
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

function love.lowmemory()
    
end