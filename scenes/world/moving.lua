local movingCharacter = {
    speed = {
        x = 0,
        y = 0
    }
}

local characterAnimation = require "scenes/world/character"
local character = require "character"
local dialogue = require "scenes/world/dialogue"

function movingCharacter:load()
    characterAnimation:load()
    
    self.info = {
        isShown = false,
        text = "",
        onConfirm = nil
    }
end

function movingCharacter:startDialogue(replicas)
    dialogue:start(replicas)
end

function movingCharacter:unload()
    characterAnimation:unload()
    self.info = nil
    self.dialogue = nil
end

function movingCharacter:update(delta_time)
    self.info.isShown = false

    character.position.x = 100 * self.speed.x * delta_time + character.position.x
    character.position.y = 100 * self.speed.y * delta_time + character.position.y
    characterAnimation:update(delta_time)
end

function movingCharacter:control_button(command)
    if dialogue.started then
        dialogue:control_button(command)
        return
    end
    if command == Command.Confirm then
        if self.info.isShown and self.info.onConfirm then
            self.info.onConfirm(self)
        end
    elseif command == Command.Deny then
        print "deny"
    end
end

function movingCharacter:getCharacterSize()
    return characterAnimation:getSize()
end

function movingCharacter:control_axis(axis, value)
    if dialogue.started or (math.abs(value) < 0.24 and value ~= 0) then
        return
    end

    self.speed[axis] = value
    
    characterAnimation:play()
    if math.abs(self.speed.x) > math.abs(self.speed.y) then
        if self.speed.x < 0 then
            characterAnimation:setState("leftward")
        elseif self.speed.x > 0 then
            characterAnimation:setState("rightward")
        end
    elseif self.speed.x == self.speed.y and self.speed.y == 0 then
        characterAnimation:stop()
    else
        if self.speed.y < 0 then
            characterAnimation:setState("upward")
        elseif self.speed.y > 0 then
            characterAnimation:setState("downward")
        end
    end
end

function movingCharacter:draw(camera)
    characterAnimation:draw()

    if dialogue.started then
        dialogue:draw(camera)
    elseif self.info.isShown then
        local h = love.graphics.getHeight()/9
        local x, y = love.graphics.inverseTransformPoint(0, love.graphics.getHeight()-h)

        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.rectangle("fill", x, y, love.graphics.getWidth(), h)
        love.graphics.setColor(0, 0, 0)

        y = y + love.graphics.getFont():getHeight()/1.5
        
        love.graphics.printf(self.info.text, x, y, (1/camera.scale)*love.graphics.getWidth(), "center")
        love.graphics.setColor(1, 1, 1)
    end
end

return movingCharacter