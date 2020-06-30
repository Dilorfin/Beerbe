require "scene_manager"
require "commands"

local scene = {}

function scene.load ()
    print "scene loaded"
end

function scene.unload()
    print "scene unloaded"
end

function scene.update(delta_time)
    print("scene update: "..delta_time)
end

function scene.control_button(command)
    if command == Command.Menu then
        print "menu"
    elseif command == Command.Confirm then
        print "confirm"
    elseif command == Command.Deny then
        print "deny"
    elseif command == Command.Up then
        print "up"
    end
end

function scene.control_axis(x_axis, y_axis)
    print(x_axis.." - "..y_axis)
end

function scene.draw()
    love.graphics.print("Hello world",0,0)
end

return scene