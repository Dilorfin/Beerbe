require "scene_manager"
require "commands"

local scene = {}

local sceneState = {
    current = 1,
    moving = 1
}

local moving = require "scenes/world/moving"
local camera = require "scenes/world/camera"

function scene.load ()
    character = require "character"
    moving:load()
end

function scene.unload()
end

function scene.update(delta_time)
    if sceneState.current == sceneState.moving then
        moving:update(delta_time)
        camera:update(character)
    end
end

function scene.control_button(command)
    if sceneState.current == sceneState.moving then
        moving:control_button(command)
    end
end

function scene.control_axis(axis, value)
    if sceneState.current == sceneState.moving then
        moving:control_axis(axis, value)
    end
end

function scene.draw()
    if sceneState.current == sceneState.moving then
        camera:influence()
        
        moving:draw()
    end
end

return scene