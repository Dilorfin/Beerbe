require "scenes/fight/enemies"
require "scene_manager"
require "commands"
require "animation"

local scene = {}

scene.sceneState = {
    current = 0,
    action = 0,
    target = 1,
    magic = 2,
    effect = 3,
    item = 4
}

local enemies = {}

local chooseAction = love.filesystem.load("scenes/fight/choose_action.lua")()

-- load effects
local effects = love.filesystem.load("scenes/fight/effects.lua")()

--load menus
local chooseMagic = love.filesystem.load("scenes/fight/choose_magic.lua")()
local chooseItem = love.filesystem.load("scenes/fight/choose_item.lua")()

function scene.load()
    -- load character
    character = require "character"
    
    -- load targeting
    scene.target = love.filesystem.load("scenes/fight/targeting.lua")()

    -- load character animation
    scene.characterAnimation = love.filesystem.load("scenes/fight/character.lua")()
    scene.characterAnimation:load()
    
    -- load resources
    scene.background = love.graphics.newImage("asserts/fight/background.png")

    chooseAction:load()
    
    -- create enemies
    local number = love.math.random(3)
    for i=1, number do
        table.insert(enemies, newEnemy(love.math.random(3), i))
    end
    enemies.current = 0
    enemies.finished = true
end

function scene.unload()
    scene.characterAnimation:unload()
    scene.characterAnimation = nil
    scene.background = nil
    scene.icons = nil
    enemies = nil
    scene.target = nil
    effects = nil
    chooseMagic = nil
    chooseItem = nil
end

function attackTarget(attackerId, targetId, skill)
    local attackerUnit = character
    if attackerId ~= scene.target.character.id then
        attackerUnit = enemies[attackerId]
    end
    
    local targetUnit = character
    if targetId ~= scene.target.character.id then
        targetUnit = enemies[targetId]
    end

    local damage = attackerUnit:useSkill(skill)
    targetUnit:takeDamage(damage)

    if targetUnit.health <= 0 and targetId ~= scene.target.character.id then
        table.remove(enemies, targetId)
    end
end

function enemies:turn()
    local slots = require "scenes/fight/slots"
    self.current = self.current + 1
    if self.current <= #enemies then
        scene.sceneState.current = scene.sceneState.effect
        effects:start("hit", scene.target.character.id)
        attackTarget(self.current, scene.target.character.id, "hit")
    else
        scene.sceneState.current = scene.sceneState.action
        self.current = 0
        self.finished = true
    end

    if #enemies <= 0 then 
        Scene.GoBack()
    end
    if character.health <= 0 then
        Scene.Load("wasted")
    end
end

function scene.update(delta_time)
    scene.characterAnimation:update(delta_time)
    if scene.sceneState.current == scene.sceneState.effect then
        effects:update(delta_time)
        if not effects:isPlaying() then
            scene.characterAnimation:setState("stand")
            enemies:turn()
        end
    end
end

function scene.control_button(command)
    if scene.sceneState.current == scene.sceneState.action then
        chooseAction:control_button(command, scene)
    elseif scene.sceneState.current == scene.sceneState.target then
        if command == Command.Left then
            scene.target:left(enemies)
        elseif command == Command.Right then
            scene.target:right(enemies)
        elseif command == Command.Confirm then
            local id = enemies[scene.target.index].slot
            if scene.target.spell == "attack" then
                scene.characterAnimation:setState("attack")
                effects:start("sword", id)
            else
                scene.characterAnimation:setState("cast")
                effects:start(scene.target.spell, id)
            end
            scene.sceneState.current = scene.sceneState.effect
            attackTarget(scene.target.character.id, scene.target.index, scene.target.spell)
        elseif command == Command.Deny then
            scene.sceneState.current = scene.sceneState.action
            scene.characterAnimation:setState("stand")
        end
    elseif scene.sceneState.current == scene.sceneState.magic then
        chooseMagic:control_button(command, scene.sceneState, scene.target)
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

    for i = 1, #enemies do
        enemies[i]:draw()
    end

    scene.characterAnimation:draw()

    if scene.sceneState.current == scene.sceneState.action then
        chooseAction:draw(menuHeight)
    elseif scene.sceneState.current == scene.sceneState.target then
        scene.target:draw(enemies)
    elseif scene.sceneState.current == scene.sceneState.effect then
        effects:draw()
    end

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
