require "scene_manager"
require "character"
require "commands"

local scene = {}

function scene.load()
    local bigFont = love.graphics.newFont("asserts/Arial.ttf", love.graphics.getHeight()/10)
    local smallFont = love.graphics.newFont("asserts/Arial.ttf", love.graphics.getHeight()/20)

    wastedText = love.graphics.newText(bigFont, "WASTED")
    infoText = love.graphics.newText(smallFont, "Press Confirm to restart")
    
    local width, height = wastedText:getDimensions()
    wastedTransform = love.math.newTransform(love.graphics.getWidth()/2 - width/2, love.graphics.getHeight()/2 - height)

    local width, height = infoText:getDimensions()
    infoTransform = love.math.newTransform(love.graphics.getWidth()/2 - width/2, love.graphics.getHeight() - 2*height)

    love.graphics.setColor(1, 0, 0)
end

function scene.unload()
    love.graphics.setColor(1, 1, 1)
    infoText = nil
    wastedText = nil
    wastedTransform = nil
    infoTransform = nil
end

function scene.update(delta_time)
end

function scene.control_button(command)
    if command == Command.Confirm then
        character.name = "Миша"
        character.position = {
            room = 0,
            last_room = love.math.random(5, 7)
        }
        
        character.health = 15
        character.mana = 5
        
        character.passive_skills = {
            health = 1,
            mana = 1
        }
        character.active_skills = {
            thunder = 0
        }
    
        character.bag = {}
        character.equipped = {}
        
        Scene.Load("dialogue")
    elseif command == Command.Deny or command == Command.Menu then
        love.event.quit()
    end
end

function scene.control_axis(x_axis, y_axis)
    
end

function scene.draw()
    love.graphics.draw(wastedText, wastedTransform)
    love.graphics.draw(infoText, infoTransform)
end

return scene