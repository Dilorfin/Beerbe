local actors = {
    currectTurn = 1, --start with players turn
    actors = {},
    positions = {
        { 
            x= 0.08125 * love.graphics.getWidth(),
            y= 0.4166666666666667 * love.graphics.getHeight()
        },
        { 
            x= 0.24375 * love.graphics.getWidth(),
            y= 0.2833333333333333 * love.graphics.getHeight()
        },
        { 
            x= 0.4 * love.graphics.getWidth(),
            y= 0.375 * love.graphics.getHeight()
        },
        {
            x = 0.75*love.graphics.getWidth(),
            y = 0.417*love.graphics.getHeight()
        }
    }
}

function actors:getCharacterId()
    return #self.actors
end

function actors:getActorsNumber()
    return #self.actors
end

function actors:getPositionById(id)
    if id == self:getCharacterId() then
        return self.positions[#self.positions]
    end
    return self.positions[id]
end

function actors:addActor(actor)
    table.insert(self.actors, actor)
end

function actors:nextTurn()
    self.actors[self.currectTurn]:turn(self)
    self.currectTurn = self.currectTurn + 1
    if self.currectTurn > #self.actors then
        self.currectTurn = 1
    end
end

function actors:attack(targetId, skill, damage)
    local targetUnit = self.actors[targetId]
    
    events:push({
        type = "start_effect",
        position = self:getPositionById(targetId),
        effect = skill
    })
    
    targetUnit:takeDamage(damage)

    if targetUnit.health <= 0 then
        if targetId == self:getCharacterId() then
            events:push("wasted")
        else
            table.remove(self.actors, targetId)
            if #self.actors == 1 then
                events:push("victory")
            end
        end
    end
end

function actors:draw()
    for i=1, #self.actors do
        if self.actors[i] then
            local position = self:getPositionById(i)
            self.actors[i]:draw(position.x, position.y)
        end
    end
end

return actors