require "scenes/world/movables/enemy"
require "scenes/world/movables/hero"
require "scenes/world/movable"

local scene = {}

local sceneState = {
    current = 1,
    moving = 1,
    menu = 2
}

local dialogue = require "scenes/world/dialogue"

local ai = require "scenes/world/ai"

local info = require "scenes/world/info"
local camera = require "scenes/world/camera"
local map = require "scenes/world/map"
local colliding = require "scenes/world/colliding"
local world

function scene.load()
    world = love.physics.newWorld()
    world:setCallbacks(colliding.beginContact, colliding.endContact, colliding.preSolve, colliding.postSolve)

    map:load(world)

    ai:load(world, map)
end

function scene.pause()
    map:pause()
end

function scene.unload()
    map:unload()
    info:close()
end


local function handleEvent(event)
    if event.type == "show_info" then
        info:show(event.text, event.onConfirm)
    elseif event.type == "close_info" and event.text == info.text then
        info:close()
    elseif event.type == "start_dialogue" then
        dialogue:start(event.replicas)
    elseif event.type == "give_items" then
        
        local groups = {}
        for i = 1, #event.items do
            local title = items[event.items[i]].title
            if not groups[title] then
                groups[title] = 0
            end
            groups[title] = groups[title] + 1
        end
        character.inventory:addItemsList(event.items)
        
        local itemsReplicas = {}
        for title, number in pairs(groups) do
            table.insert(itemsReplicas, "You got \""..title.."\" x"..number)
        end
        events:push({
            type = "start_dialogue",
            replicas = itemsReplicas
        })
    end
end


function scene.update(delta_time)
    if sceneState.current ~= sceneState.moving then
        return
    end

    world:update(delta_time)

    camera:update(character)
    
    map:update(delta_time)

    ai:update(delta_time)

    while not events:isEmpty() do
        local event = events:pop()
        if event.type == "start_fight" then
            events:clear()
            event.enemies = {}
            local enemiesNumber = love.math.random(1, 3)
            for i = 1, enemiesNumber do
                local id = map.possibleEnemies[love.math.random(1, #map.possibleEnemies)]
                table.insert(event.enemies, id)
            end
            events:push(event)
            Scene.LoadNext("fight")
            return
        elseif event.type == "next_room" then
            character.position.room = character.position.room + 1
            events:clear()
            Scene.Load("world")
            return
        end

        handleEvent(event)
    end
end

function scene.control_button(command)
    if sceneState.current == sceneState.menu then
        scene.menu:control_button(command, sceneState)
    elseif command == Command.Menu then
        sceneState.current = sceneState.menu
        scene.menu = love.filesystem.load("scenes/world/menu.lua")()
    elseif sceneState.current == sceneState.moving then
        if not dialogue.started then
            info:control_button(command)
        else
            dialogue:control_button(command)
        end
    end
end

function scene.control_axis(axis, value)
    if sceneState.current == sceneState.moving then
        if not dialogue.started then
            map.movables[1]:control_axis(axis, value)
        end
    end
end

function scene.draw()
    if sceneState.current == sceneState.moving then
        camera:influence()
        
        map:draw(camera)

        if not dialogue.started then
            info:draw(camera)
        else
            dialogue:draw(camera)
        end
        if lines then
            local r, g, b, a = love.graphics.getColor()
            love.graphics.setColor(0, 1, 0)
            for i, line in ipairs(lines) do
                love.graphics.line(line)
            end
            love.graphics.setColor(r, g, b, a)
        end

    elseif sceneState.current == sceneState.menu then
        scene.menu:draw()
    end
end

return scene