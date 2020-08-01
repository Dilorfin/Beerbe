local moving = {
    speed = {
        x = 0,
        y = 0
    }
}

function moving:update(delta_time)
    character.position.x = 100 * self.speed.x * delta_time + character.position.x
    character.position.y = 100 * self.speed.y * delta_time + character.position.y
    character.animation:update(delta_time)
end

function moving:control_button(command)
    if command == Command.Menu then
        print "menu"
    elseif command == Command.Confirm then
        print "confirm"
    elseif command == Command.Deny then
        print "deny"
    end
end

function moving:control_axis(axis, value)
    if math.abs(value) < 0.24 and value ~= 0 then
        return
    end

    self.speed[axis] = value
    
    character.animation:play()
    if math.abs(self.speed.x) > math.abs(self.speed.y) then
        if self.speed.x < 0 then
            character.animation:setState("leftward")
        elseif self.speed.x > 0 then
            character.animation:setState("rightward")
        end
    elseif self.speed.x == self.speed.y and self.speed.y == 0 then
        character.animation:stop()
    else
        if self.speed.y < 0 then
            character.animation:setState("upward")
        elseif self.speed.y > 0 then
            character.animation:setState("downward")
        end
    end
end

return moving