require "scene_manager"
require "commands"
require "animation"

local scene = {}

local index = 1
character = require "character"

function scene.load()
    local title = "scenes/dialogue/first_dialogue.lua"
    if character.position.room == character.position.last_room then
        title = "scenes/dialogue/last_dialogue.lua"
    end
    scene.scenario = love.filesystem.load(title)()
    if scene.scenario.frames[index].music then
        music:playNext(scene.scenario.frames[index].music)
    end
end

function scene.unload()
    scene.scenario = nil
end

function scene.update(delta_time)
    -- animations
    for i = 1, #scene.scenario.frames[index].animations do
        local cnf = scene.scenario.frames[index].animations[i]
        scene.scenario.resources.animations[cnf.id]:update(delta_time)
    end
end

function scene.control_button(command)
    if command == Command.Menu then
        scene.scenario:onFinish()
    elseif command == Command.Confirm then
        index = index + 1
        if index > #scene.scenario.frames then
            scene.scenario:onFinish()
        elseif scene.scenario.frames[index].music then
            music:playNext(scene.scenario.frames[index].music)
        end
    end
end

function scene.draw()
    -- scaling to current screen
    love.graphics.scale(love.graphics.getWidth()/800, love.graphics.getHeight()/600)
    local screen ={
        height = 600,
        width = 800
    }
    
    -- background
    love.graphics.draw(scene.scenario.resources.backgrounds[scene.scenario.frames[index].background])
    
    -- animations
    for i = 1, #scene.scenario.frames[index].animations do
        local cnf = scene.scenario.frames[index].animations[i]
        scene.scenario.resources.animations[cnf.id]:draw(cnf.x, cnf.y)
    end

    -- title & replica
    local textHeight = screen.height/6
    
    love.graphics.setColor(1, 1, 1, 0.9)
    love.graphics.rectangle("fill", 0, screen.height-(textHeight), screen.width, textHeight)
    love.graphics.rectangle("fill", 0, screen.height - textHeight - scene.scenario.frames[index].title:getHeight()-3, scene.scenario.frames[index].title:getWidth(), scene.scenario.frames[index].title:getHeight())
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(scene.scenario.frames[index].replica, 0, screen.height-textHeight, screen.width)
    love.graphics.draw(scene.scenario.frames[index].title, 0, screen.height-textHeight - scene.scenario.frames[index].title:getHeight()-3)
    love.graphics.setColor(1, 1, 1)
end

return scene