local movingCharacter = {
    speed = {
        x = 0,
        y = 0
    }
}

local characterAnimation = require "scenes/world/character"
local character = require "character"

function movingCharacter:load()
    characterAnimation:load()
end

function movingCharacter:unload()
    characterAnimation:unload()
end

function movingCharacter:update(delta_time)
    character.position.x = 100 * self.speed.x * delta_time + character.position.x
    character.position.y = 100 * self.speed.y * delta_time + character.position.y
    characterAnimation:update(delta_time)
end

function movingCharacter:control_button(command)
    if command == Command.Menu then
        print "menu"
    elseif command == Command.Confirm then
        print "confirm"
    elseif command == Command.Deny then
        print "deny"
    end
end

function movingCharacter:getCharacterSize()
    return characterAnimation:getSize()
end

function movingCharacter:control_axis(axis, value)
    if math.abs(value) < 0.24 and value ~= 0 then
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

function movingCharacter:draw()
    characterAnimation:draw()
end

return movingCharacter