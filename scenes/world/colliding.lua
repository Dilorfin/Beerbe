local colliding = {}

function colliding.beginContact(fixture1, fixture2, contact)
    local obj1 = fixture1:getUserData()
    local obj2 = fixture2:getUserData()
    if obj1.onStartCollide then
        local event = obj1:onStartCollide(obj2)
        events:push(event)
    end
    if obj2.onStartCollide then
        local event = obj2:onStartCollide(obj1)
        events:push(event)
    end
end

function colliding.endContact(fixture1, fixture2, contact)
    local obj1 = fixture1:getUserData()
    local obj2 = fixture2:getUserData()
    if obj1.onEndCollide then
        local event = obj1:onEndCollide(obj2)
        events:push(event)
    end
    if obj2.onEndCollide then
        local event = obj2:onEndCollide(obj1)
        events:push(event)
    end
end

function colliding.preSolve(fixture1, fixture2, contact)
end

function colliding.postSolve(fixture1, fixture2, contact, normalimpulse, tangentimpulse)
end

return colliding
