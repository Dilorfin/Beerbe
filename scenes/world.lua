require "scene_manager"
require "commands"

local scene = {}

local sceneState = {
    current = 1,
    moving = 1
}

function scene.load ()
    character = require "scenes/world/character"
    character.animation:load()
end

function scene.unload()
    character.animation:unload()
end

function scene.update(delta_time)
    if sceneState.current == sceneState.moving then
        character.animation:update(delta_time)
    end
end

function scene.control_button(command)
    if sceneState.current == sceneState.moving then
        if command == Command.Menu then
            print "menu"
        elseif command == Command.Confirm then
            print "confirm"
        elseif command == Command.Deny then
            print "deny"
        end
    end
end

function scene.control_axis(x_axis, y_axis)
    if sceneState.current == sceneState.moving then
        print(x_axis.." - "..y_axis)
    end
end

function scene.draw()
    character.animation:draw()
end

return scene