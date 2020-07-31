require "scenes/fight/enemy"
require "scene_manager"
require "commands"
require "animation"

local scene = {}

sceneState = {
    action = 0,
    target = 1,
    magic = 2,
    effect = 3
}
local enemies = {}

function scene.load()
    -- load character
    character = require "scenes/fight/character"
    character.animation:load()
    
    -- load effects
    effects = require "scenes/fight/effects"

    -- load targeting
    target = require "scenes/fight/targeting"
    chooseMagic = require "scenes/fight/choose_magic"

    -- load resources
    background = love.graphics.newImage("asserts/fight/background.png")
    
    local iconsFilenames = {
        "asserts/fight/sword.png",
        "asserts/fight/shield.png",
        "asserts/fight/magic.png",
        "asserts/fight/beer-bottle.png",
        "asserts/fight/run.png"
    }
    icons = love.graphics.newArrayImage(iconsFilenames)
    
    -- create enemies
    local type = 0
    local number = 3--love.math.random(3)
    for i=1, number do
        table.insert(enemies, newEnemy(2, i))
    end
    enemies.current = 0
    enemies.finished = true

    -- init variables
    choose = 0
    state = sceneState.action
end

function attackTarget(attackerId, targetId, skill)
    local attackerUnit = character
    if attackerId ~= target.character.id then
        attackerUnit = enemies[attackerId]
    end
    
    local targetUnit = character
    if targetId ~= target.character.id then
        targetUnit = enemies[targetId]
    end

    local damage = attackerUnit:useSkill(skill)
    targetUnit:takeDamage(damage)

    if targetUnit.health <= 0 and targetId ~= target.character.id then
        table.remove(enemies, targetId)
    end
end

function enemies:turn()
    local slots = require "scenes/fight/slots"
    self.current = self.current + 1
    if self.current <= #enemies then
        state = sceneState.effect
        effects:start("hit", target.character.id)
        attackTarget(self.current, target.character.id, "hit")
    else
        state = sceneState.action
        self.current = 0
        self.finished = true
    end

    if #enemies <= 0 then 
        -- TODO: return to world 
    end
    if character.health <= 0 then
        Scene.Load("wasted")
    end
end

-- TODO: clearing
function scene.unload()
    character.animation:unload()
    background = nil
    icons = nil
    enemies = nil
    target = nil
end

function scene.update(delta_time)
    character.animation:update(delta_time)
    if state == sceneState.effect then
        effects:update(delta_time)
        if not effects:isPlaying() then
            character.animation:setState("stand")
            enemies:turn()
        end
    end
end

function scene.control_button(command)
    if state == sceneState.action then
        if command == Command.Left then
            if choose > 0 then
                choose = choose - 1
            end
        elseif command == Command.Right then
            if choose < icons:getLayerCount()-1 then
                choose = choose + 1
            end
        elseif command == Command.Confirm then
            if choose == 0 then
                state = sceneState.target
                target.spell = "attack"
                target.index = 1
            elseif choose == 1 then
                --character.animation:setState("protect")
            elseif choose == 2 then
                state = sceneState.magic
                character.animation:setState("cast")
                target.spell = "magic"
                target.index = 1
            elseif choose == 3 then
                love.event.quit()
            elseif choose == 4 then
                love.event.quit()
            end
        elseif command == Command.Deny then
            --character.animation:setState("stand")
        end
    elseif state == sceneState.target then
        if command == Command.Left then
            target:left(enemies)
        elseif command == Command.Right then
            target:right(enemies)
        elseif command == Command.Confirm then
            local id = enemies[target.index].slot
            if target.spell == "attack" then
                character.animation:setState("attack")
                effects:start("sword", id)
            else
                character.animation:setState("cast")
                effects:start(target.spell, id)
            end
            state = sceneState.effect
            attackTarget(target.character.id, target.index, target.spell)
        elseif command == Command.Deny then
            state = sceneState.action
        end
    elseif state == sceneState.magic then
        chooseMagic:control_button(command)
    end
end

function scene.draw()

    if state == sceneState.magic then
        chooseMagic:draw()
        return
    end

    local menuHeight = love.graphics.getHeight() / 6
    
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), (love.graphics.getHeight() - menuHeight) / background:getHeight())

    for i = 1, #enemies do
        enemies[i]:draw()
    end

    character.animation:draw()

    if state == sceneState.action then
        local menuItemSize = love.graphics.getHeight() / 7
        local offset = (menuHeight - menuItemSize)/2

        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", offset + choose *  menuHeight, offset + love.graphics.getHeight() - menuHeight, menuItemSize, menuItemSize, 10, 10)
        love.graphics.setLineWidth(1)

        for i = 1, icons:getLayerCount() do
            love.graphics.drawLayer(icons, i, offset + (i - 1) * menuHeight, offset + love.graphics.getHeight() - menuHeight, 0, menuItemSize / icons:getWidth())
        end
    elseif state == sceneState.target then
        target:draw(enemies)
    elseif state == sceneState.effect then
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
