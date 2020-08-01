require "scene_manager"
require "commands"

local scene = {}

local sceneState = {
    current = 1,
    moving = 1
}

function scene.load ()
    moving = require "scenes/world/moving"
    character = require "scenes/world/character"
    character.animation:load()
end

function scene.unload()
    character.animation:unload()
    moving = nil
end

function scene.update(delta_time)
    if sceneState.current == sceneState.moving then
        moving:update(delta_time)
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
    character.animation:draw()
end

return scene