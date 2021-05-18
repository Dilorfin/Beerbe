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

local info = require "scenes/world/info"
local menu = require "scenes/world/menu"
local camera = require "scenes/world/camera"
local map = require "scenes/world/map"
local colliding = require "scenes/world/colliding"
local astar = require "utils/lua-star"

local world = love.physics.newWorld()
local path = nil

function scene.load()
    world:setCallbacks(colliding.beginContact, colliding.endContact, colliding.preSolve, colliding.postSolve)

    map:load(world)

    menu:load()
end

function scene.pause()
    map:pause()
end

function scene.unload()
    map:unload()
    menu:unload()
    info:close()
end

function positionIsOpenFunc(x, y)
    -- should return true if the position is open to walk
    return map:isTilePassable(x,y)
end

function path_finding(map, movables)
    -- movables[1] - player
    -- movables[>1] - enemies
    for i = 2, #movables do
        path = astar:find(
            map.width,
            map.height,
            movables[i]:getMapPosition(),
            movables[1]:getMapPosition(),
            positionIsOpenFunc
        )

        if path then
            movables[i]:control_axis("x", (path[2].x-path[1].x)/2)
            movables[i]:control_axis("y", (path[2].y-path[1].y)/2)
        end
    end
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
    if sceneState.current == sceneState.moving then
        world:update(delta_time)

        camera:update(character)
        
        map:update(delta_time)

        path_finding(map, map.movables)
        
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
                Scene.Load("world")
                return
            end

            handleEvent(event)
        end
    elseif sceneState.current == sceneState.menu then
        menu:update(delta_time)
    end
end

function scene.control_button(command)
    if command == Command.Menu and sceneState.current ~= sceneState.menu then
        sceneState.current = sceneState.menu
    elseif sceneState.current == sceneState.moving then
        if not dialogue.started then
            info:control_button(command)
        else
            dialogue:control_button(command)
        end
    elseif sceneState.current == sceneState.menu then
        menu:control_button(command, sceneState)
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
        
        if path then
            local temp = {}
            for i, v in pairs(path) do
                table.insert(temp, v.x * map:getTileSide() + map:getTileSide()/2)
                table.insert(temp, v.y * map:getTileSide() + map:getTileSide()/2)
            end
            r, g, b, a = love.graphics.getColor()
            love.graphics.setColor(0, 1, 0)
            love.graphics.line(temp)
            love.graphics.setColor(r, g, b, a)
        end
    elseif sceneState.current == sceneState.menu then
        menu:draw()
    end
end

return scene