require "utils/animation"
require "scenes/fight/enemies"

local scene = {}

scene.sceneState = {
    current = 0,
    action = 0,
    target = 1,
    magic = 2,
    item = 3,
    none = 4
}

local actors = love.filesystem.load("scenes/fight/actors.lua")()

local chooseAction = love.filesystem.load("scenes/fight/choose_action.lua")()

-- load effects
local effects = love.filesystem.load("scenes/fight/effects.lua")()

--load menus
local chooseMagic = love.filesystem.load("scenes/fight/choose_magic.lua")()
local chooseItem = love.filesystem.load("scenes/fight/choose_item.lua")()

function scene.load()
    while not events:isEmpty() do
        local event = events:pop()
        if event.type == "start_fight" then
            for i=1, #event.enemies do
                actors:addActor(newEnemy(event.enemies[i], i))
            end
        end
    end
    -- add character
    actors:addActor(character)
    -- load targeting
    scene.target = love.filesystem.load("scenes/fight/targeting.lua")()

    -- load character animation
    character.animation = love.filesystem.load("scenes/fight/ch_animation.lua")()
    character.animation:load()
    character.draw = function(self, x, y)
        self.animation:draw(x, y)
    end
    
    -- load resources
    scene.background = love.graphics.newImage("asserts/fight/background.png")

    chooseAction:load()
end

function scene.unload()
    character.animation:unload()
    character.animation = nil

    scene.background = nil
    scene.icons = nil
    scene.target = nil
    effects = nil
    chooseMagic = nil
    chooseItem = nil
    chooseAction = nil
end

function scene.update(delta_time)
    while not events:isEmpty() do
        local event = events:pop()
        if event.type == "start_effect" then
            effects:start(event.effect, event.position)
            scene.sceneState.current = scene.sceneState.none
        elseif event.type == "end_effect" then
            character.animation:setState("stand") -- TODO: check if it can be removed
            actors:nextTurn()
        elseif event.type == "attack" then
            actors:attack(event.target, event.skill, event.damage)
        elseif event.type == "user_action" then
            scene.sceneState.current = scene.sceneState.action
        elseif event.type == "wasted" then
            events:clear()
            Scene.Load("wasted")
            return
        elseif event.type == "victory" then
            events:clear()
            Scene.GoBack()
            return
        else
            scene.sceneState.current = scene.sceneState.none
            print(event.type)
        end
    end

    character.animation:update(delta_time)
    effects:update(delta_time)
end

function scene.control_button(command)
    if scene.sceneState.current == scene.sceneState.action then
        chooseAction:control_button(command, scene)
    elseif scene.sceneState.current == scene.sceneState.target then
        
        if command == Command.Confirm then
            local pos = actors:getPositionById(scene.target.index)
            
            if scene.target.spell == "attack" then
                character.animation:setState("attack")
                scene.target.spell = "sword"
            end

            events:push({
                type = "attack",
                damage = character:useSkill(scene.target.spell),
                target = scene.target.index,
                skill = scene.target.spell
            })
            
        elseif command == Command.Deny then
            scene.sceneState.current = scene.sceneState.action
            character.animation:setState("stand")
        else
            scene.target:control_button(command)
        end
    elseif scene.sceneState.current == scene.sceneState.magic then
        chooseMagic:control_button(command, scene)
    elseif scene.sceneState.current == scene.sceneState.item then
        chooseItem:control_button(command, scene.sceneState)
    end
end

function scene.draw()

    if scene.sceneState.current == scene.sceneState.magic then
        chooseMagic:draw()
        return
    elseif scene.sceneState.current == scene.sceneState.item then
        chooseItem:draw()
        return
    end

    local menuHeight = love.graphics.getHeight() / 6
    
    love.graphics.draw(scene.background, 0, 0, 0, love.graphics.getWidth() / scene.background:getWidth(), (love.graphics.getHeight() - menuHeight) / scene.background:getHeight())

    actors:draw()

    if scene.sceneState.current == scene.sceneState.action then
        chooseAction:draw(menuHeight)
    elseif scene.sceneState.current == scene.sceneState.target then
        scene.target:draw()
    end

    effects:draw()
    drawCharacterInfo()
end

function drawCharacterInfo()
    local menuHeight = love.graphics.getHeight() / 6
    local menuItemSize = love.graphics.getHeight() / 7
    local offset = (menuHeight - menuItemSize)/2
    
    local barSize = {}
    barSize.x = love.graphics.getWidth() - 8 * menuItemSize - offset
    barSize.y = menuHeight / 6 

    local healthPosition = {
        x = 8 * menuItemSize,
        y = love.graphics.getHeight() - menuHeight + 2 * barSize.y 
    }

    local manaPosition = {
        x = 8 * menuItemSize,
        y = love.graphics.getHeight() - menuHeight + 4 * barSize.y 
    }
    
    love.graphics.printf(character.name, healthPosition.x, love.graphics.getHeight() - menuHeight + 0.5 * barSize.y ,  barSize.x / (0.00125 * love.graphics.getHeight()), "center", 0, 0.00125 * love.graphics.getHeight())

    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", healthPosition.x, healthPosition.y, barSize.x, barSize.y )
    love.graphics.rectangle("line", manaPosition.x, manaPosition.y, barSize.x, barSize.y )
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", healthPosition.x, healthPosition.y, character.health * barSize.x / character:getMaxHealth(), barSize.y )
    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("fill", manaPosition.x, manaPosition.y, character.mana * barSize.x / character:getMaxMana(), barSize.y )
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(1)
    
    love.graphics.printf(character.health.."/"..character:getMaxHealth(), healthPosition.x, healthPosition.y,  barSize.x / (0.001 * love.graphics.getHeight()), "center", 0, 0.001 * love.graphics.getHeight())
    love.graphics.printf(character.mana.."/"..character:getMaxMana(), manaPosition.x, manaPosition.y,  barSize.x / (0.001 * love.graphics.getHeight()), "center", 0, 0.001 * love.graphics.getHeight())
end

function scene.control_axis(x_axis, y_axis)
end

return scene
