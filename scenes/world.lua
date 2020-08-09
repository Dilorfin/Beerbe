require "scene_manager"
require "commands"

local scene = {}

local sceneState = {
    current = 1,
    moving = 1
}

local moving = require "scenes/world/moving"
local camera = require "scenes/world/camera"
local map = require "scenes/world/map"
local colliding = require "scenes/world/colliding"

function scene.load ()
    character = require "character"
    
    map:load(character)
    moving:load()
    colliding:load(moving:getCharacterSize())
end

function scene.unload()
    map:unload()
    moving:unload()
end

function scene.update(delta_time)
    if sceneState.current == sceneState.moving then
        moving:update(delta_time)
        camera:update(character)
        
        map:update(delta_time)
        
        colliding:collide(moving, map)
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
        
        map:draw(camera)
        moving:draw(camera)
    end
end

return scene