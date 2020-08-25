require "scene_manager"
require "commands"

local scene = {}

local sceneState = {
    current = 1,
    moving = 1,
    menu = 2
}

local menu = require "scenes/world/menu"
local moving = require "scenes/world/moving"
local camera = require "scenes/world/camera"
local map = require "scenes/world/map"
local colliding = require "scenes/world/colliding"

character = require "character"
music = require "music_manager"

function scene.load()
    map:load(character)
    moving:load(map:getFightFrequency())
    colliding:load(moving:getCharacterSize())

    menu:load()

    music:playNext(map.musicTheme)
end

function scene.resume()
    music:playNext(map.musicTheme)
end

function scene.pause()
    moving:pause()
end

function scene.unload()
    map:unload()
    moving:unload()
    menu:unload()
end

function scene.update(delta_time)
    if sceneState.current == sceneState.moving then
        moving:update(delta_time)
        camera:update(character)
        
        map:update(delta_time)
        
        colliding:collide(moving, map)
    elseif sceneState.current == sceneState.menu then
        menu:update(delta_time)
    end
end

function scene.control_button(command)
    if command == Command.Menu and sceneState.current ~= sceneState.menu then
        sceneState.current = sceneState.menu
    elseif sceneState.current == sceneState.moving then
        moving:control_button(command)
    elseif sceneState.current == sceneState.menu then
        menu:control_button(command, sceneState)
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
    elseif sceneState.current == sceneState.menu then
        menu:draw()
    end
end

return scene