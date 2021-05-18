local eventQueue = {
    events = {}
}

function eventQueue:push(event)
    if event then
        if type(event) == "string" then
            event = {
                type = event
            }
        elseif not event.type then
            error("event must have type")
        end
        table.insert(self.events, event)
    end
end

function eventQueue:pop()
    return table.remove(self.events)
end

function eventQueue:isEmpty()
    return #self.events == 0
end

function eventQueue:clear()
    table.clear(self.events)
end

return eventQueue